//
//  OptionScheduleViewController.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 03.06.2022.
//

import UIKit

class OptionScheduleTableViewController: UITableViewController {

    private let idOptionSheduleCell = "idOptionSheduleCell"
    private let idOptionSheduleHeader = "idOptionSheduleHeader"
    private var scheduleModel = ScheduleModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.bounces = false

        tableView.register(OptionsScheduleTableViewCell.self, forCellReuseIdentifier: idOptionSheduleCell)
        tableView.register(HeaderOptionScheduleTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionSheduleHeader)

        title = "Option Schedule"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }

    @objc private func saveButtonTapped() {
        if scheduleModel.date == nil || scheduleModel.name == "Unknown" {
            alertOk(title: "Error", message: "Requered fields: Date, Name")
        } else {
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            alertOk(title: "Success", message: nil)
            scheduleModel = ScheduleModel()
            tableView.reloadRows(at: [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1]], with: .none)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        default:
            return 2
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionSheduleCell, for: indexPath) as! OptionsScheduleTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionSheduleHeader) as! HeaderOptionScheduleTableViewCell
        header.headerConfigure(section: section)
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsScheduleTableViewCell
        switch indexPath {
        case [0, 0]: alertDate(label: cell.nameCellLabel) { date in
            self.scheduleModel.date = date
        }
        case[0, 1]: alertTime(label: cell.nameCellLabel) { time in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeStr = dateFormatter.string(from: time)
            self.scheduleModel.dateStart = timeStr
        }
        case[0, 2]: alertTime(label: cell.nameCellLabel) { time in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeStr = dateFormatter.string(from: time)
            self.scheduleModel.dateFinish = timeStr
        }
        case[1, 0]: alertText(label: cell.nameCellLabel, name: "Name Deal", placeholder: "Enter the name") { text in
            self.scheduleModel.name = text
        }
        case[1, 1]: alertText(label: cell.nameCellLabel, name: "Description Deal", placeholder: "Enter the description") { text in
            self.scheduleModel.descriptionDeal = text
        }
        default:
            print("Error")
        }
    }
}
