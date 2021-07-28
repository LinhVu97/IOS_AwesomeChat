//
//  RegisterViewController.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 22/07/2021.
//

import UIKit
import Firebase
import FirebaseDatabase

class RegisterViewController: UIViewController {
    @IBOutlet weak private var nameText: UITextField!
    @IBOutlet weak private var emailText: UITextField!
    @IBOutlet weak private var passText: UITextField!
    @IBOutlet weak private var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyBoard()
        setupTextField()
    }
    
    // MARK: - Dismiss Keyboard
    private func keyBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
     
    // Dismiss Keybroad
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Setup Text Field.
    private func setupTextField() {
        // Name Text
        let imageNameTextField = UIImage(asset: .user)
        nameText.iconTextField(image: imageNameTextField ?? UIImage())
        nameText.delegate = self
        
        // Email Text
        let imageEmailTextField = UIImage(asset: .email)
        emailText.iconTextField(image: imageEmailTextField ?? UIImage())
        emailText.delegate = self
        
        // Password Text
        let imagePassTextField = UIImage(asset: .key)
        passText.iconTextField(image: imagePassTextField ?? UIImage())
        passText.delegate = self
        passText.isSecureTextEntry = true
    }
    
    // MARK: - Button
    @IBAction func registerBtn(_ sender: UIButton) {
        guard let name = nameText.text, !name.isEmpty else {
            nameText.text = ""
            return
        }
        
        // Validate Email
        guard let email = emailText.text, email.isValid(.email) else {
            alert(title: Localized.alertErrorTitleEmail, message: Localized.alertErrorMessageLogin) {
                emailText.text = ""
            }
            return
        }
        
        // Validate Password
        guard let password = passText.text, password.isValid(.password) else {
            alert(title: Localized.alertErrorTitlePassword, message: Localized.alertErrorMessageLogin) {
                passText.text = ""
            }
            return
        }
        
        // Register
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil else {
                // Fail to sign up
                self?.alert(title: Localized.failToRegister, message: "") {
                    self?.nameText.text = ""
                    self?.emailText.text = ""
                    self?.passText.text = ""
                }
                return
            }
            
            guard let uid = result?.user.uid else { return }
            let values = ["email": email, "username": name]
            
            // Save data in Firebase
            Database.database().reference().child("users").child(uid).updateChildValues(values) { [weak self] err, ref in
                guard err == nil else {
                    
                    return
                }
                self?.alert(title: Localized.successRegister, message: "") {
                    self?.handlerLogin()
                }
            }
        }
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        handlerLogin()
    }
    
    private func handlerLogin() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension
extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textString = textField.text as NSString? else {
            return false
        }
        let text = textString.replacingCharacters(in: range, with: string)
        
        // Enable and Disable Button
        registerBtn?.isUserInteractionEnabled = !text.isEmpty
        if !text.isEmpty {
            registerBtn.setBackgroundImage(UIImage(asset: .buttonBgActive), for: .normal)
        } else {
            registerBtn.setBackgroundImage(UIImage(asset: .buttonBgDisable), for: .normal)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameText:
            emailText.becomeFirstResponder()
        case emailText:
            passText.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
