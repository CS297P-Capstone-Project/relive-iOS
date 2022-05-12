//
//  ViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/9/22.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var password: UITextView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var loginCredentials : [String : String] = ["test":"test"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldBorder(textField: username)
        setTextFieldBorder(textField: password)
        
        username.delegate = self
        username.text = "username"
        username.textColor = UIColor.lightGray
        
        password.delegate = self
        password.text = "password"
        password.isSecureTextEntry.toggle()
        password.textColor = UIColor.lightGray
        
    }
    
    
    func textViewDidBeginEditing(_ textView :UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        if !textView.text.isEmpty {
            setTextFieldBorder(textField: textView)
        }
    }
    
    func textViewDidEndEditing(_ textView :UITextView) {
        if textView.text.isEmpty {
            let borderColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha: 1.0)
            textView.layer.borderColor = borderColor.cgColor
            errorLabel.text = "Please enter all required details."
        } else {
            setTextFieldBorder(textField: textView)
        }
    }
    
    func setTextFieldBorder (textField :UITextView) {
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
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
}

