//
//  ViewController.swift
//  CalendarTestOne
//
//  Created by Алексей Каллистов on 19.05.2022.
//

import UIKit
import FSCalendar

class ScheduleViewController: UIViewController {
    
    var calendarHeightContraint: NSLayoutConstraint!
    //Color(#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1))
    private var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    let showHeightButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open caledar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "Shedule"
        
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.scope = .week
        
        setCpntrains()
        swipeAction()
        
        showHeightButton.addTarget(self, action: #selector(showHeightButtonTapped), for: .touchUpInside)
    }
    
    @objc func showHeightButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHeightButton.setTitle("Close calendar", for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHeightButton.setTitle("Open caledar", for: .normal)
        }
        calendar.scope = .month
    }
    
    //MARK: SwipeGestureRecognizer
    
    func swipeAction() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUp.direction = .up
        calendar.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case .up:
            showHeightButtonTapped()
        case .down:
            showHeightButtonTapped()
        default:
            break
        }
    }
}

extension ScheduleViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightContraint.constant = bounds.height
        view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
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
            //calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(showHeightButton)

        NSLayoutConstraint.activate([
            showHeightButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHeightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHeightButton.heightAnchor.constraint(equalToConstant: 20),
            showHeightButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
