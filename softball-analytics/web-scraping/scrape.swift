//
//  scrape.swift
//  softball-analytics
//
//  Created by Hank Elsesser on 9/26/25.
//

import SwiftSoup

func validate_school_name(schedule_links: [String: String], school_name: String) -> String {
    if let link: String = schedule_links[school_name] {
        return link
    } else {
        fatalError("Not a valid school name: \(school_name)")
    }
}

func main() {
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

    print("hi")
    for year in [2025] {
        for school_name in ["williams"] {
            var url: String = validate_school_name(schedule_links: schedule_links, school_name: school_name)
            print(url)
        }
    }
}

main()
