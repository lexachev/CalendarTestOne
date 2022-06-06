//
//  AlertTime.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import UIKit

extension UIViewController {

    func alertTime(label: UILabel, completionHanger: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "Ru.ru") as Locale

        alert.view.addSubview(datePicker)

        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeStr = dateFormatter.string(from: datePicker.date)
            let time = datePicker.date as Date
            completionHanger(time)

            label.text = timeStr
        }

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)
        alert.view.heightAnchor.constraint(equalToConstant: 300).isActive = true

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.widthAnchor.constraint(equalTo: alert.view.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 160).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true

        present(alert, animated: true, completion: nil)
    }
}
