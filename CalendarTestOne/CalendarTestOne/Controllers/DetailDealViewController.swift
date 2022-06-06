//
//  DetailDealViewController.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 06.06.2022.
//

import UIKit

class DetailDealViewController: UIViewController {
    let dateLabel: UILabel = UILabel(text: "", font: .avenirNext14())
    let nameDeal: UILabel = UILabel(text: "", font: .avenirNext14())
    let time: UILabel = UILabel(text: "", font: .avenirNext14(), alignment: .right)
    let descriptionDeal: UILabel = UILabel(text: "", font: .avenirNext20())

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"

        setConstraints()
    }

    func setConstraints() {

        let topStackView = UIStackView(arrangedSubviews: [nameDeal, dateLabel, time], axis: .horizontal, spacing: 10, distribution: .fillEqually)

        view.addSubview(topStackView)
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25)
        ])

        view.addSubview(descriptionDeal)
        NSLayoutConstraint.activate([
            descriptionDeal.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            descriptionDeal.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            descriptionDeal.widthAnchor.constraint(equalToConstant: view.frame.width),
            descriptionDeal.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}
