//
//  ProfileViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/20/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var pswdResetBtn: UIButton!
    @IBOutlet weak var notificationsBtn: UIButton!
    @IBOutlet weak var privacyBtn: UIButton!
    @IBOutlet weak var tcBtn: UIButton!
    @IBOutlet weak var helpBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pswdResetBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        notificationsBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        privacyBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        tcBtn.layer.borderColor = UIColor.lightGray.cgColor
        
        helpBtn.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @IBAction func pswdResetBtnPressed(_ sender: Any) {
    }
    
    @IBAction func notificationsBtnPressed(_ sender: Any) {
    }
    
    @IBAction func privacyBtnPressed(_ sender: Any) {
    }
    
    @IBAction func tcBtnPressed(_ sender: Any) {
    }
    
    @IBAction func helpBtnPressed(_ sender: Any) {
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
    }
    
}
