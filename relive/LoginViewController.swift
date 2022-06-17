//
//  ViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/9/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var username: UITextField!
 
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginCredentials : [String : String] = ["peter":"peter"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldBorder(textField: username)
        setTextFieldBorder(textField: password)
        
        username.delegate = self
        username.text = "username"
        username.textColor = UIColor.lightGray
        
        password.delegate = self
        password.text = "password"
        password.textColor = UIColor.lightGray
        
    }
    @IBAction func unHideBtnPressed(_ sender: Any) {
        self.password.isSecureTextEntry.toggle()
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
        if !(textField.text!.isEmpty) {
            setTextFieldBorder(textField: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            let borderColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha: 1.0)
            textField.layer.borderColor = borderColor.cgColor
            errorLabel.text = "Please enter all required details."
        } else {
            setTextFieldBorder(textField: textField)
        }
    }
    
    func setTextFieldBorder (textField :UITextField) {
        let borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha: 1.0)
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        username.becomeFirstResponder()
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        username.resignFirstResponder()
        
        let usernameValue = username.text ?? ""
        let passwordValue = password.text ?? ""
        var isCredentialValid :Bool = false
        if loginCredentials[usernameValue] == nil {
            isCredentialValid = false
        } else {
            if loginCredentials[usernameValue] != passwordValue {
                isCredentialValid = false
            } else {
                isCredentialValid = true
            }
        }
        
        if !isCredentialValid {
            errorLabel.text = "Incorrect username or password."
        } else {
            errorLabel.text = ""
            // switch to home screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController")
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            self.present(vc, animated: true, completion: nil);
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
}

