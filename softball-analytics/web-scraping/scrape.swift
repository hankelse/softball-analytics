//
//  A scraper to get box score/play by play PDFs off the NESCAC athletics websites
//  scrape.swift
//  softball-analytics
//
//  Josh Smith
//  10/1/25
//

import Foundation
import SwiftSoup

func fetch_text(from urlString: String) async throws -> String {
    // Get the html from a url, acting like the request.get function
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }

    guard let text = String(data: data, encoding: .utf8) else {
        throw URLError(.cannotDecodeRawData)
    }

    return text
}


func get_box_score_links(url: String, base_url: String) async throws -> [String] {
    // Get links to box scores for all games in a season
    let html: String = try await fetch_text(from: url)
    
    var links: Set<String> = Set<String>()
    do {
        let doc: Document = try SwiftSoup.parse(html)
        let results: Elements = try doc.select("li.sidearm-schedule-game-links-boxscore")

        for result in results {
            if let anchor = try result.select("a").first() {
                let text: String = try anchor.text()

                if text.contains("Box Score") {
                    let href: String = try anchor.attr("href")
                    let fullURL: String = base_url + href
                    links.insert(fullURL)
                }
            }
        }
    } catch {
        print("Parsing error: \(error)")
    }

    return Array(links)
}


func get_pdf_view_link(_ url: String) async throws -> String {
    // Get link for PDF view from link to box score page
    let html: String = try await fetch_text(from: url)

    let doc: Document = try SwiftSoup.parse(html)
    guard let span = try doc.select("span.icon-pdf").first(),
          let parent = span.parent(),
          let href = try? parent.attr("href") else {
        throw NSError(domain: "PDFLinkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "PDF link not found"])
    }

    return href
}


func get_download_link(from url: String) async throws -> String {
    // Get link to download picture 
    let html = try await fetch_text(from: url)

    let doc: Document = try SwiftSoup.parse(html)
    let anchors: Elements = try doc.select("a")

    var fullLink: String?

    for anchor in anchors {
        let text = try anchor.text()
        if text.contains("Download Document") {
            fullLink = try anchor.attr("href")
            break
        }
    }

    guard let link = fullLink else {
        throw NSError(domain: "DownloadLinkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Download link not found"])
    }

    guard let range = link.range(of: "file_location=") else {
        throw NSError(domain: "DownloadLinkError", code: 2, userInfo: [NSLocalizedDescriptionKey: "file_location parameter not found"])
    }

    let startIndex = link.index(range.upperBound, offsetBy: 0)
    let fileLocation = String(link[startIndex...])

    return fileLocation
}


func school_name_to_url(schedule_links: [String: String], school_name: String) -> String {
    // Return the corresponding athletics page link to the given school after checking that it's in the dictionary
    if let link: String = schedule_links[school_name] {
        return link
    } else {
        fatalError("Not a valid school name: \(school_name)")
    }
}


func download_pdf(url: String, local_filename: String) async throws -> Void {
    // Download PDF into pdfs folder from the given downloadable link
    guard let url: URL = URL(string: url) else {
        throw URLError(.badURL)
    }

    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }

    // Get file path to write to
    let fileURL: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        .appendingPathComponent(local_filename)

    do {
        try data.write(to: fileURL)
        print("PDF '\(local_filename)' downloaded successfully.")
    } catch {
        print("Error writing PDF to disk: \(error.localizedDescription)")
        throw error
    }
}


func main() async {
    // Controls the flow of the program
    let schedule_links: [String: String] = [
        "amherst": "https://athletics.amherst.edu/sports/softball/schedule",
        "bates": "https://gobatesbobcats.com/sports/softball/schedule",
        "bowdoin": "https://athletics.bowdoin.edu/sports/softball/schedule",
        "colby": "https://colbyathletics.com/sports/softball/schedule",
        "hamilton": "https://athletics.hamilton.edu/sports/softball/schedule",
        "middlebury": "https://athletics.middlebury.edu/sports/softball/schedule",
        "trinity": "https://bantamsports.com/sports/softball/schedule",
        "tufts": "https://gotuftsjumbos.com/sports/softball/schedule",
        "wesleyan": "https://athletics.wesleyan.edu/sports/softball/schedule",
        "williams": "https://ephsports.williams.edu/sports/softball/schedule",
    ]

    for year in [2025] {
        let school_names = schedule_links.keys.sorted()
        for school_name: String in school_names {
            let url: String = school_name_to_url(schedule_links: schedule_links, school_name: school_name)
            let base_url: String = String(url.prefix(url.count - "/sports/softball/schedule".count))

            do {
                let links: [String] = try await get_box_score_links(url: url, base_url: base_url)
                for (index, link) in links.enumerated() {
                    let pdf_view_link: String = try await base_url + get_pdf_view_link(link)

                    let downloadable_link: String = try await get_download_link(from: pdf_view_link)

                    print("Downloading PDF...")
                    try await download_pdf(url: downloadable_link, local_filename: "pdfs/\(school_name)-\(year)-\(index).pdf")
                }
            } catch {
                print("Error getting box score links:", error)
            }
        }
    }
}

Task {
    await main()
    CFRunLoopStop(CFRunLoopGetMain())
}
CFRunLoopRun()
