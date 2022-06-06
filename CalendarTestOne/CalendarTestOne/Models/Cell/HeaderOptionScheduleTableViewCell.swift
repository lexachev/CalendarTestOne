//
//  HeaderOptionScheduleTableViewCell.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 05.06.2022.
//

import Foundation
import UIKit

class HeaderOptionScheduleTableViewCell: UITableViewHeaderFooterView {

    let headerLabel = UILabel(text: "", font: .avenirNext20())

    let headerNameArray = ["Date and time", "Name and description"]

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        headerLabel.textColor = .black
        self.contentView.backgroundColor = .systemGray6
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func headerConfigure(section: Int) {
        headerLabel.text = headerNameArray[section]
    }

    func setConstraints() {

        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])

    }
}
