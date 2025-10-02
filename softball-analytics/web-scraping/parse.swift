//
//  A parser to get box score/play by play info from PDFs
//  parse.swift
//  softball-analytics
//
//  Josh Smith
//  10/1/25
//
import Foundation
import PDFKit

func get_files() -> [String] {
    // Return a list of all PDF filenames from the pdfs folder
    let fileManager = FileManager.default
    let directoryPath: String = FileManager.default.currentDirectoryPath + "/pdfs"

    do {
        let contents: [String] = try fileManager.contentsOfDirectory(atPath: directoryPath)
        return contents.sorted()
    } catch {
        print("Error reading directory: \(error)")
        return []
    }
}


class GameParser {
    var filename: String = ""
    var text: String = ""

    // def __init__(self, filename: str):
    //     self.filename = filename
    //     self.text = self._get_pdf_text(filename)

    init(filename: String) {
        self.filename = filename
        self.text = self._get_pdf_text(filename)
    }

    func parse() throws -> String {
        print(self.text)
        return ""
    }

    // def _get_pdf_text(self, filename: str) -> str:
    //     """Get full text from PDF file"""
    //     reader = PdfReader("pdfs/" + filename)
    //     text = ""
    //     for index, page in enumerate(reader.pages):
    //         if index:
    //             text += '\n'
    //         text += page.extract_text()
        
    //     return text

    func _get_pdf_text(_ filename: String) -> String {
        // Get full text from PDF file
        let fileURL = URL(fileURLWithPath: "pdfs/\(filename)")

        guard let pdfDocument = PDFDocument(url: fileURL) else {
            print("Failed to load PDF: \(filename)")
            return ""
        }

        var text: String = ""

        for page_num: Int in 0..<pdfDocument.pageCount {
            if let page: PDFPage = pdfDocument.page(at: page_num),
            let pageText: String = page.string {
                if page_num > 0 {
                    text += "\n"
                }
                text += pageText
            }
        }

        return text
    }
}


func main() {
    // Controls the flow of the program
    let files: [String] = get_files()
    var fails: Int = 0
    for filename: String in files {
        let parser = GameParser(filename: filename)
        do {
            let data = try parser.parse()
            print(data)
        } catch { // TODO: Figure out how to display specifics of error
            print("failed parsing \(filename)")
            fails += 1
        }
        break
    }

    print("Total fails: \(fails) / \(files.count)")
}

main()
