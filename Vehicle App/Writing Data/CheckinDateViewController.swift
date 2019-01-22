//
//  CheckinDateViewController.swift
//  Vehicle App
//
//  Created by Timothy P. Konopacki on 12/5/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
class CheckinDateViewController: UIViewController{
    var ref: DatabaseReference!
    var returnDate: Date?
    var checkoutDate: Date?
    //var interval: DateInterval?
    var vehiclesDates: NSMutableDictionary?
    var busDates: NSDictionary?
    var vanDates: NSDictionary?
    var timeInt: String?
    var unixReturn: TimeInterval?
    //var unixReturn = 0.0
    var unixCheckout: TimeInterval?

    //var pickerData: [String] = [String]()
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var returnDateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //checkoutDate = CheckoutDateViewController.checkout
    }
        // Do any additional setup after loading the view.
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.full
        returnDate = datePickerOutlet.date
    }
    @IBAction func proceedAction(_ sender: UIButton) {
        convertDate()
        testDate()
        performSegue(withIdentifier: "bothdatesSegue", sender: "UIButton")
        
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if(sender as? String == "UIButton") {
//            //print(sender)
//            let nvc = segue.destination as! selectedDatesViewController
//            //let index = busTableOutlet.indexPathForSelectedRow?.row
//            nvc.inDate = returnDate
//            nvc.outDate = CheckoutDateViewController.checkout
//            //collegeArray[(indexPath?.row)!]
//        } else {
//            print("Back")
//        }
    //}
    func checkTheBusDates(){
        ref = Database.database().reference()
        ref.child("Buses").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            for child in value!{
                let check: NSDictionary = child.value as! NSDictionary
                let datezB = check.value(forKey: "checkedOutArray") as Any
                let theKeyB = child.key as! String
                //self.busDates = [theKeyB : datezB!]
                self.busDates = [theKeyB : datezB]
                //print(self.busDates!)
                //self.busDates?.isEqual(to: [theKeyB : datezB!])
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    func checkTheVanDates(){
    ref = Database.database().reference()
    ref.child("Vans").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    for child in value!{
                        let check: NSDictionary = child.value as! NSDictionary
                        let datez = check.value(forKey: "checkedOutArray") as Any
                        let theKey = child.key as! String
                        self.vanDates = [theKey : datez]
                        //vanDatesIn = self.vanDates as! [String : Any]
                    }
//        print(self.vanDates!)
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    func testDate(){
        checkTheBusDates()
        checkTheVanDates()
        for check in vanDates!{
            let dateRange = check.value as! String
            let dateArrayz = dateRange.components(separatedBy: "-")
            var databaseCheckoutDub = dateArrayz[0]
            var databaseReturnDub = dateArrayz[1]
//            if  Double(unixCheckout!) >= Double(databaseReturnDub) || Double(unixReturn!) <= Double(databaseCheckoutDub){
//
//            }
            
        }
    }
    func convertDate(){
        unixReturn = returnDate?.timeIntervalSince1970
        unixCheckout = CheckoutDateViewController.checkout?.timeIntervalSince1970
        timeInt = "\(unixCheckout!)-\(unixReturn!)"
    }
    func writeData(){
        ref = Database.database().reference()
        self.ref.child("Buses/B5201/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
        self.ref.child("Buses/B6202/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
        self.ref.child("Buses/B6204/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
        self.ref.child("Buses/B7203/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
        self.ref.child("Buses/B8204/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
        self.ref.child("Vans/Sub9204/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
        self.ref.child("Vans/V7202/checkedOutArray/\((Auth.auth().currentUser?.uid)!)").setValue(timeInt)
    }
//
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
