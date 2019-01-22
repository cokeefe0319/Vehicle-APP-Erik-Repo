//
//  adminViewController.swift
//  Vehicle App
//
//  Created by period2 on 12/3/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class adminViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var busRequests = [selectedBusViewController.selectedBus]
    var vanRequests = [Any]()
    var ref: DatabaseReference!
//    var busRequest: Bus!
//    var vanRequest: Van!
    
    @IBOutlet weak var adminTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //busRequests.append(selectedBus)
        adminTableView.delegate = self
        adminTableView.dataSource = self
        adminTableView.reloadData()
        print(busRequests)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adminCell", for: indexPath)
        cell.textLabel?.text = "Bus" + " " + (busRequests[indexPath.row]  as! Bus).key
        
        if (busRequests[indexPath.row] as! Bus).availability == true{
            cell.textLabel?.textColor = UIColor.green
            cell.detailTextLabel?.text = "Available"
        }
        else if (busRequests[indexPath.row] as! Bus ).availability == false{
            cell.textLabel?.textColor = UIColor.red
            cell.detailTextLabel?.text = "Checked out by" + " " + (busRequests[indexPath.row] as! Bus).checkoutUser
        }
        
        adminTableView.reloadData()
        return cell
    }
    
    @IBAction func testButton(_ sender: UIButton) {
    print(busRequests)
    }
    

}
