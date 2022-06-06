//
//  CalendarTestOneTests.swift
//  CalendarTestOneTests
//
//  Created by Алексей Каллистов on 19.05.2022.
//

import XCTest
@testable import CalendarTestOne

class CalendarTestOneTests: XCTestCase {
    func testOnlyDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateStr = "\(dateFormatter.string(from: date)) 00:00"
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        XCTAssertEqual(dateFormatter.string(from: date.onlyDate!), dateStr)
    }
}
