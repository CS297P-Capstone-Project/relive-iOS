//
//  SignupViewController.swift
//  relive
//
//  Created by Tanya Lohiya on 5/10/22.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var reEnteredPassword: UITextField!
    
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
    
    func setTextFieldBorder (textField :UITextField) {
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        showErrorPopup()
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
        if !textField.text!.isEmpty {
            setTextFieldBorder(textField: textField)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            setBorderRed(textField)
            errorLabel.text = "Please enter all required details."
        } else {
            setTextFieldBorder(textField: textField)
        }
    }
    
    func setBorderRed (_ textField :UITextField){
        let borderColor = UIColor(red:1.0, green:0.0, blue:0.0, alpha: 1.0)
        textField.layer.borderColor = borderColor.cgColor
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
            showErrorPopup()
        }
        
    }
    
    func showErrorPopup() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "ErrorPopUp") as! ErrorViewController
        vc.modalPresentationStyle = .fullScreen
        vc.errorText = "New registrations are closed! Please visit booth 30 to experience Relive!"
        vc.cancelBtnRedirectVCId = "LoginScreen"
        self.present(vc, animated: true, completion: nil);
    }

}
