//
//  CheckoutDateViewController.swift
//  Vehicle App
//
//  Created by Timothy P. Konopacki on 12/5/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit

class CheckoutDateViewController: UIViewController {
    public static var checkout: Date?
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var checkoutDateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func checkoutPicker(_ sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.full
        dateFormatter.timeStyle = DateFormatter.Style.full
        //checkout = dateFormatter.date(from: datePickerOutlet!.date)
        CheckoutDateViewController.checkout = datePickerOutlet.date
        //return checkout
    }
    @IBAction func proceedButton(_ sender: UIButton) {
         performSegue(withIdentifier: "dateSegue", sender: "UIButton")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(sender as? String == "UIButton") {
            //print(sender)
            let nvc = segue.destination as! CheckinDateViewController
            //let index = busTableOutlet.indexPathForSelectedRow?.row
            nvc.checkoutDate = CheckoutDateViewController.checkout
            //collegeArray[(indexPath?.row)!]
        } else {
            print("Back")
            }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
