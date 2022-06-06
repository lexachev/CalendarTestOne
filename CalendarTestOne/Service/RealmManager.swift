//
//  RealmManager.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    func saveScheduleModel(model: ScheduleModel) {
        try! realm.write {
                realm.add(model)
            }
    }
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! realm.write {
                realm.delete(model)
            }
    }
}
