//
//  ScheduleTableViewCell.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 23.05.2022.
//

import Foundation
import UIKit

class ScheduleTableViewCell: UITableViewCell {

    let nameDeal: UILabel = UILabel(text: "Дело №1", font: .avenirNext20(), alignment: .right)
    let timeDeal: UILabel = UILabel(text: "13:00 - 14:00", font: .avenirNext20())
    let descriptionDeal: UILabel = UILabel(text: "Описание дела", font: .avenirNext14())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        self.selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setConstraints() {

        let topStackView = UIStackView(arrangedSubviews: [timeDeal, nameDeal], axis: .horizontal, spacing: 10, distribution: .fillEqually)

        self.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])

        self.addSubview(descriptionDeal)
        NSLayoutConstraint.activate([
            descriptionDeal.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            descriptionDeal.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            descriptionDeal.widthAnchor.constraint(equalToConstant: 100),
            descriptionDeal.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
