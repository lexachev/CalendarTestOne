//
//  AlertText.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import UIKit

extension UIViewController {
    func alertText(label: UILabel, name: String, placeholder: String, completionHanger: @escaping (String) -> Void) {

        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)

        let ok = UIAlertAction(title: "Ok", style: .default) { (_) in
            let tfAlert = alert.textFields?.first
            guard let text = tfAlert?.text else { return }
            label.text = (text != "" ? text : label.text)
            completionHanger(text)
        }

        alert.addTextField { (tfAlert) in
            tfAlert.placeholder = placeholder
        }

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)

        alert.addAction(ok)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
}
