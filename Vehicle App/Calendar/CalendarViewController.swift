//
//  CalendarViewController.swift
//  Vehicle App
//
//  Created by period2 on 11/20/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Firebase
import FirebaseDatabase

class CalendarViewController: UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {

    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    let formatter = DateFormatter()
    var busesArray = [Bus]()
    var ref: DatabaseReference!
    var busAvail: Bool!
    var vanAvail: Bool!
    var vanPicked: Bool!
    var busPicked: Bool!
    var busDateReserved = [NSDate]()
    var vanDateReserved = [NSDate]()
    let numberOfVans = 3
    let numberOfBuses = 5
    
    //I just put placeholder colors for the segments of the calendar, we can change these when we want to start focusing on the looks of the app
    let outDatesColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 1.0, alpha: 0.25) //color of dates that aren't in the current month
    let monthDates = UIColor.white //color of dates that are in the current month
    let currentDateColor = UIColor.gray //color of the current date in the calendar
    let selectedDateColor = UIColor.blue //color of a date on the calendar when it is selected/chosen
    let dayColor = UIColor.white //color of days of the week (mon, tue, wed, etc...)
    let monthColor = UIColor.black
    let yearColor = UIColor.black
    let currentDate = NSDate()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let testDate = NSDate()
        busDateReserved.append(testDate)
        busDateReserved.append(testDate)
        busDateReserved.append(testDate)
        busDateReserved.append(testDate)
        busDateReserved.append(testDate)
        vanDateReserved.append(testDate)
        vanDateReserved.append(testDate)
        vanDateReserved.append(testDate)
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self
        setupCalenderView()
    }
    
    func setupCalenderView()
    {
        calendar.minimumLineSpacing = 0
        calendar.minimumInteritemSpacing = 0
        
        calendar.visibleDates { (visibleDates) in
            let date = visibleDates.monthDates.first!.date
            self.formatter.dateFormat = "yyyy"
            self.yearLabel.text = self.formatter.string(from: date)
            self.formatter.dateFormat = "MMMM"
            self.monthLabel.text = self.formatter.string(from: date)
        }
        calendar.scrollToDate(currentDate as Date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        myCustomCell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        myCustomCell.dateLabel.text = cellState.text
        handleCellSelected(view: myCustomCell, cellState: cellState)
        handleCellTextColor(view: myCustomCell, cellState: cellState)
        
        let cellDate = cellState.date
        myCustomCell.selectionView.isHidden = false
        myCustomCell.selectionView.alpha = 0.25
        checkReservedForDate(myCustomCell: myCustomCell, cellState: cellState, cellDate: cellDate)
        handleCalendarColors(myCustomCell: myCustomCell)
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        let currentYear = Calendar.current.component(.year, from: Date())
        let startDate = formatter.date(from:  "\(currentYear - 1) 01 01")!
        let endDate = formatter.date(from: "\(currentYear + 5) 12 31")!
        let paramaters = ConfigurationParameters(startDate: startDate, endDate: endDate, generateOutDates: .tillEndOfRow)
        return paramaters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState)
    {
        guard let validCell = view as? CustomCell else {return}
        if cellState.dateBelongsTo == .thisMonth
        {
            validCell.dateLabel.textColor = monthColor
        }
        else
        {
            validCell.dateLabel.textColor = outDatesColor
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState)
    {
        guard let validCell = view as? CustomCell else {return}
        if cellState.isSelected
        {
            validCell.selectionView?.isHidden = false
        }
        else
        {
            validCell.selectionView?.isHidden = true
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = self.formatter.string(from: date)
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = self.formatter.string(from: date)
    }
    
    func handleCalendarColors(myCustomCell: CustomCell)
    {
        if busPicked == true && vanPicked == false
        {
            if busAvail == true
            {
            myCustomCell.selectionView.backgroundColor = UIColor.green
            }
            else
            {
            myCustomCell.selectionView.backgroundColor = UIColor.red
            }
        }
        
        if busPicked == false && vanPicked == true
        {
            if vanAvail == true
            {
                myCustomCell.selectionView.backgroundColor = UIColor.green
            }
            else
            {
                myCustomCell.selectionView.backgroundColor = UIColor.red
            }
        }
        
        if busPicked == true && vanPicked == true
        {
            if vanAvail == true || busAvail == true
            {
                myCustomCell.selectionView.backgroundColor = UIColor.green
            }
            else
            {
                myCustomCell.selectionView.backgroundColor = UIColor.red
            }
        }
    }
    
    func checkReservedForDate(myCustomCell: CustomCell, cellState: CellState, cellDate: Date)
    {
        var busCounter = 0
        var vanCounter = 0
    for var date in busDateReserved
        {
            date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())! as NSDate
            if cellDate == date as Date
            {
                busCounter += 1
                print("Bus reserved for day")
            }
        }
    for var date in vanDateReserved
        {
            date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())! as NSDate
            if cellDate == date as Date
            {
                vanCounter += 1
                print("Van reserved for day")
            }
        }
        
        print(vanCounter)
        print(busCounter)
        if vanCounter == numberOfVans
        {
            vanAvail = false
        }
        else
        {
            vanAvail = true
        }
        
        if busCounter == numberOfBuses
        {
            busAvail = false
        }
        else
        {
            busAvail = true
        }
    }
}
