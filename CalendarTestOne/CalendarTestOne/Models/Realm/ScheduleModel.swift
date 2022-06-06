//
//  ScheduleModel.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import RealmSwift

class ScheduleModel: Object {
    @objc dynamic var name = "Unknown"
    @objc dynamic var date: Date?
    @objc dynamic var dateStart = "00:00"
    @objc dynamic var dateFinish = "23:59"
    @objc dynamic var descriptionDeal = "Unknown"
}
