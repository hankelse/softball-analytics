//
//  A parser to get box score/play by play info from PDFs
//  parse.swift
//  softball-analytics
//
//  Josh Smith
//  10/1/25
//
import Foundation


func get_files() -> [String] {
    // Return a list of all PDF filenames from the pdfs folder
    let fileManager = FileManager.default
    let directoryPath = FileManager.default.currentDirectoryPath + "/pdfs"

    do {
        let contents = try fileManager.contentsOfDirectory(atPath: directoryPath)
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

    func _get_pdf_text(_ filename: String) -> String {
        return ""
    }

    func parse() throws -> String {
        return ""
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
    }

    print("Total fails: \(fails) / \(files.count)")
}

main()
