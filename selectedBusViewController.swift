//
//  selectedBusViewController.swift
//  Vehicle App
//
//  Created by Timothy P. Konopacki on 11/30/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit

class selectedBusViewController: UIViewController{
    
    @IBOutlet weak var busLicensePlateLabel: UILabel!
    @IBOutlet weak var licenseplateLabel: UILabel!
    @IBOutlet weak var selectedBusImage: UIImageView!

    @IBOutlet weak var busTimeLabel: UILabel!
    @IBOutlet weak var busMonthLabel: UILabel!
    @IBOutlet weak var checkoutByLabel: UILabel!
    //var selectedBus: Bus!
    public static var selectedBus: Bus!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //print(selectedBus)
        populateLabels()
    }
    
    @IBAction func reserveButton(_ sender: Any) {
    selectedBusViewController.selectedBus.requested = true
        print(selectedBusViewController.selectedBus)
    }
    
    func populateLabels(){
        let busTimeOut = String(selectedBusViewController.selectedBus.timeOut)
        let busTimeIn = String(selectedBusViewController.selectedBus.timeIn)
        let busDatein = selectedBusViewController.selectedBus.dateIn
        busLicensePlateLabel.text! = selectedBusViewController.selectedBus.licensePlate
        busTimeLabel.text! = "From" + " " + busTimeOut + " " + "To" + " " + busTimeIn
        busMonthLabel.text! = "On" + " " + busDatein
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            let nvc = segue.destination as! ViewController
//            //nvc.busRequest = selectedBus
//        
//    }

}
