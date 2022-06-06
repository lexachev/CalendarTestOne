//
//  JsonReader.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 05.06.2022.
//

import Foundation

final class JsonReader {
    private init() {}

    func parseJSON() {
        print("sss")
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else { return }
        print("ddd")
        print(path)
        let url = URL(fileURLWithPath: path)
        var result: ResponseDeals?
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(ResponseDeals.self, from: jsonData)
            print("ddd")
            if let result = result {
                print(result)
            } else {
                print("Failed to parse")
            }
            return
        } catch {
            print("Error: \(error)")
        }
    }
}

struct ResponseDeals: Codable {
    let data: [Deal]
}

struct Deal: Codable {
    let id: Int
    let date_start: String
    let date_finish: String
    let name: String
    let description: String
}
