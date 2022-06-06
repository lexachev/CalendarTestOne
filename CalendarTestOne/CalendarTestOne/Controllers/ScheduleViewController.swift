//
//  ViewController.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 19.05.2022.
//

import UIKit
import FSCalendar
import RealmSwift

class ScheduleViewController: UIViewController {

    var calendarHeightContraint: NSLayoutConstraint!

    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()

    private let showHeightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open caledar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.bounces = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    let localRealm = try! Realm()
    var scheduleArray: Results<ScheduleModel>!

    private let idScheduleCell = "idScheduleCell"

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Shedule"

        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: idScheduleCell)

        setCpntrains()
        swipeAction()
//        let calender = Calendar.current
//        var dateComponents = calender.dateComponents([.year, .month, .day], from: Date())
//        dateComponents.timeZone = NSTimeZone.system
        scheduleOnDay(date: Date().onlyDate!)

        showHeightButton.addTarget(self, action: #selector(showHeightButtonTapped), for: .touchUpInside)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }

    @objc private func addButtonTapped() {
        let scheduleOption = OptionScheduleTableViewController()
        navigationController?.pushViewController(scheduleOption, animated: true)
    }

    @objc private func showHeightButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHeightButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHeightButton.setTitle("Open caledar", for: .normal)
        }
        calendar.scope = .month
    }

    // MARK: SwipeGestureRecognizer

    private func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }

    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up:
            showHeightButtonTapped()
        case .down:
            showHeightButtonTapped()
        default:
            break
        }
    }

    private func scheduleOnDay(date: Date) {
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        let predicateDate = NSPredicate(format: "date BETWEEN %@", [dateStart, dateEnd])
        scheduleArray = localRealm.objects(ScheduleModel.self).filter(predicateDate).sorted(byKeyPath: "dateStart")
        tableView.reloadData()
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idScheduleCell, for: indexPath) as! ScheduleTableViewCell
        let model = scheduleArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailDeal = DetailDealViewController()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateStr = dateFormatter.string(from: scheduleArray[(tableView.indexPathForSelectedRow?.row)!].date!)
        detailDeal.nameDeal.text = "Name: \(scheduleArray[(tableView.indexPathForSelectedRow?.row)!].name)"
        detailDeal.dateLabel.text = "Date: \(dateStr)"
        detailDeal.time.text = "Time: \(scheduleArray[(tableView.indexPathForSelectedRow?.row)!].dateStart) - \(scheduleArray[(tableView.indexPathForSelectedRow?.row)!].dateFinish)"
        detailDeal.descriptionDeal.text = "Description: \(scheduleArray[(tableView.indexPathForSelectedRow?.row)!].descriptionDeal)"
        navigationController?.pushViewController(detailDeal, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = scheduleArray[indexPath.row]
        let deleteAction =  UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            RealmManager.shared.deleteScheduleModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightContraint.constant = bounds.height
        view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        scheduleOnDay(date: date)
    }
}

extension ScheduleViewController {
    func setCpntrains() {
        view.addSubview(calendar)

        calendarHeightContraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightContraint)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])

        view.addSubview(showHeightButton)
        NSLayoutConstraint.activate([
            showHeightButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHeightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHeightButton.heightAnchor.constraint(equalToConstant: 20),
            showHeightButton.widthAnchor.constraint(equalToConstant: 100)
        ])

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHeightButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
