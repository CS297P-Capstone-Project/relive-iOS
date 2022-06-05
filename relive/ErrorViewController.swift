//
//  ErrorViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/21/22.
//

import UIKit

class ErrorViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var cancelBtnPressed: UIButton!
    public var errorText: String = ""
    public var cancelBtnRedirectVCId:String = "LoginScreen"

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 10
        
        popUpView.layer.shadowColor = UIColor.black.cgColor
        popUpView.layer.shadowOffset = CGSize(width: 3, height: 3)
        popUpView.layer.shadowOpacity = 10
        popUpView.layer.shadowRadius = 15
        
        errorLabel.text = errorText
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        // switch to cancelBtnRedirectVCId screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: cancelBtnRedirectVCId);
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil);
    }

}
