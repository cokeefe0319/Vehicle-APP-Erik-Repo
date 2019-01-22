//
//  VansViewController.swift
//  Vehicle App
//
//  Created by period2 on 12/5/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class VansViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var vansTableView: UITableView!
    var vansArray = [Van]()
    var ref: DatabaseReference!
    var name = ""
    var vanAval: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        getBusesTest()
        vansTableView.delegate = self
        vansTableView.dataSource = self
        getVansTest()
        vansTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vansArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vanCell", for: indexPath)
        cell.textLabel?.text = "Van" + " " + vansArray[indexPath.row].key
        
        if vansArray[indexPath.row].availability == true{
            cell.textLabel?.textColor = UIColor.green
            cell.detailTextLabel?.text = "Available"
        }
        else if vansArray[indexPath.row].availability == false{
            cell.textLabel?.textColor = UIColor.red
            cell.detailTextLabel?.text = "Checked out by" + " " + vansArray[indexPath.row].checkoutUser
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectedVanSegue", sender: "TableView")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(sender as? String == "TableView") {
            let nvc = segue.destination as! selectedVanViewController
            let index = vansTableView.indexPathForSelectedRow?.row
            nvc.selectedVan = vansArray[(index)!]
        }
    }

    
    func getVansTest(){
        ref = Database.database().reference()
        ref.child("Vans").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            for child in value!{
                let vanDeets: NSDictionary = child.value as! NSDictionary
                let aval = vanDeets.value(forKey: "Availability") as! Bool
                let lp = vanDeets.value(forKey: "LicensePlate") as! String
                let checkoutUser = vanDeets.value(forKey: "checkoutUser") as! String
                let dateIn = vanDeets.value(forKey: "dateIn") as! String
                let dateOut = vanDeets.value(forKey: "dateOut") as! String
                let timeIn = vanDeets.value(forKey: "timeIn") as! Int
                let timeOut = vanDeets.value(forKey: "timeOut") as! Int
                let requested = vanDeets.value(forKey: "Requested") as! Bool
                print(child)
                let indVan = Van(availability: aval, licensePlate: lp, checkoutUser: checkoutUser, dateIn: dateIn, dateOut: dateOut, timeIn: timeIn, timeOut: timeOut, ky: child.key as! String, requested: requested)
                self.vansArray.append(indVan)
                self.vansTableView.reloadData()
            }
            print(self.vansArray)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    

}
