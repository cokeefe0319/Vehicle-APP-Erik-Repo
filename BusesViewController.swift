//
//  BusesViewController.swift
//  Vehicle App
//
//  Created by Timothy P. Konopacki on 11/15/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class BusesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var busTableOutlet: UITableView!
    //var busesArray: Array<Any> = [Bus]()
    var busesArray = [Bus]()
    //var busesArray = [Bus]()
    //var BusesArrayMe = [Bus]()
    var ref: DatabaseReference!
    var name = ""
    var busAval: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        //dataPull().getBuses()
        //print(busesArray)
        getBusesTest()
        busTableOutlet.reloadData()
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "busCell", for: indexPath)
        //let indBus = busesArray[indexPath.row]
        //busesArray[indexPath.row].availability = busAval
        cell.textLabel?.text = "Bus" + " " + busesArray[indexPath.row].key
        
        if busesArray[indexPath.row].availability == true{
            cell.textLabel?.textColor = UIColor.green
            cell.detailTextLabel?.text = "Available"
        }
        else if busesArray[indexPath.row].availability == false{
            cell.textLabel?.textColor = UIColor.red
            cell.detailTextLabel?.text = "Checked out by" + " " + busesArray[indexPath.row].checkoutUser
        }
        
    
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedBus = busesArray[indexPath.row]
        performSegue(withIdentifier: "selectedBusSegue", sender: "TableView")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(sender as? String == "TableView") {
            let nvc = segue.destination as! selectedBusViewController
            let index = busTableOutlet.indexPathForSelectedRow?.row
            selectedBusViewController.selectedBus = busesArray[(index)!]
            //collegeArray[(indexPath?.row)!]
        }
    }
    
    func getBusesTest(){
        ref = Database.database().reference()
        ref.child("Buses").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            for child in value!{
                let busDeets: NSDictionary = child.value as! NSDictionary
                let aval = busDeets.value(forKey: "Availability") as! Bool
                let lp = busDeets.value(forKey: "LicensePlate") as! String
                let checkoutUser = busDeets.value(forKey: "checkoutUser") as! String
                let dateIn = busDeets.value(forKey: "dateIn") as! String
                let dateOut = busDeets.value(forKey: "dateOut") as! String
                let timeIn = busDeets.value(forKey: "timeIn") as! Int
                let timeOut = busDeets.value(forKey: "timeOut") as! Int
                let requested = busDeets.value(forKey: "Requested") as! Bool
                print(child)
                let indBus = Bus(availability: aval, licensePlate: lp, checkoutUser: checkoutUser, dateIn: dateIn, dateOut: dateOut, timeIn: timeIn, timeOut: timeOut, ky: child.key as! String, requested: requested)
                self.busesArray.append(indBus)
                self.busTableOutlet.reloadData()
            }
            print(self.busesArray)
        }) { (error) in
            print(error.localizedDescription)
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
