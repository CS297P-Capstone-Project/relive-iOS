//
//  ErrorViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/21/22.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 10
        
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOffset = CGSize(width: 3, height: 3)
        popUpView.layer.shadowOpacity = 10
        popUpView.layer.shadowRadius = 15

    }

}
