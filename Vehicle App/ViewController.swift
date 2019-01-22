//
//  ViewController.swift
//  Vehicle App
//
//  Created by Timothy P. Konopacki on 10/31/18.
//  Copyright © 2018 TK. All rights reserved.
//

import UIKit
import MessageUI
import GoogleSignIn
import CoreData
import FirebaseAuth
import Firebase
class ViewController: UIViewController, GIDSignInUIDelegate, MFMailComposeViewControllerDelegate{

    var signedIn = false
    var vans = false
    var cars = false
    var busRequest: Bus!
    let googleButton = GIDSignInButton()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     setupGoogleButton()
        signedIn = appDelegate.signedIn
        print("test")
        print("test2")
        if signedIn == false{
            timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(hideGoogleSignIn), userInfo: nil, repeats: true)
        }else{
            if signedIn == true{
                hideGoogleSignIn()
            }
        }


    }
    
   
    fileprivate func setupGoogleButton(){
        googleButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32 , height: 50)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance()?.uiDelegate = self
        //hideGoogleSignIn()
        
    }
    
    func retryLogin(){
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func hideGoogleSignIn(){
        self.signedIn = self.appDelegate.signedIn
        if self.signedIn == false{
            self.googleButton.isHidden = false
        }else{
            if self.signedIn == true{
                self.googleButton.isHidden = true
            }
        }
        
    }

    
    @IBAction func vanChosen(_ sender: UIButton) {
        vans = true
        cars = false
        if signedIn == false{
            notSignedInAlert()
        }

        //performSegue(withIdentifier: "calendarSegue", sender: nil)
    }
    
    @IBAction func carChosen(_ sender: UIButton) {
//        cars = true
//        vans = false
//        if signedIn == false{
//            notSignedInAlert()
//        }
//        performSegue(withIdentifier: "calendarSegue", sender: nil)
    }

    @IBAction func bothChosen(_ sender: UIButton) {
        cars = true
        vans = true
        if signedIn == false{
            notSignedInAlert()
        }
        //performSegue(withIdentifier: "calendarSegue", sender: nil)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nvc = segue.destination as? adminViewController
//        nvc?.busRequest = busRequest
//    }
    
    @objc func notSignedInAlert(){
        let alertController = UIAlertController(title: "Sign in first", message: nil, preferredStyle: .alert)
        let cancelAlert = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAlert = UIAlertAction(title: "Retry", style: .default, handler:  { (action) in
            self.retryLogin()
        })
        alertController.addAction(okAlert)
        alertController.addAction(cancelAlert)
        present(alertController, animated: true, completion: nil)
    }
    
//    func sendEmail() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setPreferredSendingEmailAddress((Auth.auth().currentUser?.email)!)
//            mail.setToRecipients(["you@yoursite.com"])
//            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//
//            present(mail, animated: true)
//        } else {
//            // show failure alert
//        }
//    }
//
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }

}

