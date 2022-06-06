//
//  AlertDate.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import UIKit

extension UIViewController {

    func alertDate(label: UILabel, completionHanger: @escaping (Date) -> Void) {
        let alert = UIAlertController(title: "", message: nil, preferredStyle: .actionSheet)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels

        alert.view.addSubview(datePicker)

        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateStr = dateFormatter.string(from: datePicker.date)
            let date = datePicker.date as Date
            completionHanger(date)

            label.text = dateStr
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
