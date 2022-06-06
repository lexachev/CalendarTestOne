//
//  UILabel.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 03.06.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment: NSTextAlignment = .left) {
        self.init()
        self.text = text
        self.textColor = .black
        self.font = font
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
