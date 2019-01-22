//
//  selectedVanViewController.swift
//  Vehicle App
//
//  Created by period2 on 12/5/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit

class selectedVanViewController: UIViewController {
    @IBOutlet weak var selectedVanImage: UIImageView!
    @IBOutlet weak var vanLicensePlate: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var checkedOutByLabel: UILabel!
    @IBOutlet weak var vanMonthLabel: UILabel!
    @IBOutlet weak var busTimeLabel: UILabel!
    var selectedVan: Van!

    override func viewDidLoad() {
        super.viewDidLoad()
        populateLabels()
    }
    
    
    @IBAction func reserveVan(_ sender: UIButton) {
        selectedVan.requested = true
    }
    
    func populateLabels(){
        let vanTimeOut = String(selectedVan.timeOut)
        let vanTimeIn = String(selectedVan.timeIn)
        let vanDatein = selectedVan.dateIn
        vanLicensePlate.text! = selectedVan.licensePlate
        busTimeLabel.text! = "From" + " " + vanTimeOut + " " + "To" + " " + vanTimeIn
        vanMonthLabel.text! = "On" + " " + vanDatein
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nvc = segue.destination as! ViewController
////        nvc.selectedVan = selectedVan
//        
//    }


}
