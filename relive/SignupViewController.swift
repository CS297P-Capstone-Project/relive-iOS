//
//  SignupViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/10/22.
//

import UIKit

class SignupViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var firstName: UITextView!
    @IBOutlet weak var lastName: UITextView!
    @IBOutlet weak var username: UITextView!
    @IBOutlet weak var password: UITextView!
    @IBOutlet weak var reEnteredPassword: UITextView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldBorder(textField: firstName)
        setTextFieldBorder(textField: lastName)
        setTextFieldBorder(textField: username)
        setTextFieldBorder(textField: password)
        setTextFieldBorder(textField: reEnteredPassword)
        
        firstName.delegate = self
        firstName.text = "Enter firstName"
        firstName.textColor = UIColor.lightGray
        
        lastName.delegate = self
        lastName.text = "Enter lastName"
        lastName.textColor = UIColor.lightGray
        
        username.delegate = self
        username.text = "Enter username"
        username.textColor = UIColor.lightGray
        
        password.delegate = self
        password.text = "Enter password"
        password.textColor = UIColor.lightGray
        
        reEnteredPassword.delegate = self
        reEnteredPassword.text = "Re-enter password"
        reEnteredPassword.textColor = UIColor.lightGray
    }
    
    func setTextFieldBorder (textField :UITextView) {
        let borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha: 1.0)
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = borderColor.cgColor
        textField.layer.cornerRadius = 5.0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        username.resignFirstResponder()
        password.resignFirstResponder()
        reEnteredPassword.resignFirstResponder()
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
            setBorderRed(textView)
            errorLabel.text = "Please enter all required details."
        } else {
            setTextFieldBorder(textField: textView)
        }
    }
    
    func setBorderRed (_ textView :UITextView){
        let borderColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha: 1.0)
        textView.layer.borderColor = borderColor.cgColor
    }

    @IBAction func signUpBtnPressed(_ sender: Any) {
        let pswdValue = password.text ?? ""
        let reEnteredPswdValue = reEnteredPassword.text ?? ""
        let usernameValue = username.text ?? ""
        let firstNameValue = firstName.text ?? ""
        let lastNameValue = lastName.text ?? ""
        
        if firstNameValue.isEmpty || lastNameValue.isEmpty || usernameValue.isEmpty
        {
            errorLabel.text = "Please enter all required details."
        } else if pswdValue != reEnteredPswdValue {
            errorLabel.text = "Password do not match."
            setBorderRed(password)
            setBorderRed(reEnteredPassword)
        } else {
            errorLabel.text = ""
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
