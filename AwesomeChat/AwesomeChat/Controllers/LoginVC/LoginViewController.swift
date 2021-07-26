//
//  LoginViewController.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 22/07/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak private var emailText: UITextField!
    @IBOutlet weak private var passText: UITextField!
    @IBOutlet weak private var btnLogin: UIButton!
    
    let registerView = RegisterViewController()
    let forgotPassView = ForgotPassViewController()
    let tabbarView = TabbarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        keyBoard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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

    // MARK: - Setup Text Field
    private func setupTextField() {
        // Email Text
        let imageEmailTextField = UIImage(asset: .email)
        emailText.iconTextField(image: imageEmailTextField ?? UIImage())
        emailText.delegate = self
        
        // Password Text
        let imagePassTextField = UIImage(asset: .key)
        passText.iconTextField(image: imagePassTextField ?? UIImage())
        passText.delegate = self
    }
    
    // MARK: - Button
    @IBAction private func loginBtn(_ sender: UIButton) {
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
        
        // Authentication
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else {
                return
            }
            
            // Error when no account in DB
            guard error == nil else {
                self.alertHandle(title: Localized.alertTitleCreateAcc,
                                 message: Localized.alertMessageCreateAcc,
                                 titleAction: Localized.create) {
                    self.changeVC(vc: self.registerView)
                }
                return
            }
            
            // Success
            self.alert(title: Localized.success, message: "") { [weak self] in
                self?.changeVC(vc: self?.tabbarView ?? UIViewController())
            }
        }
    }
    
    @IBAction private func forgotBtn(_ sender: UIButton) {
        changeVC(vc: forgotPassView)
    }
    
    @IBAction private func registerBtn(_ sender: UIButton) {
        changeVC(vc: registerView)
    }
    
    private func changeVC(vc: UIViewController) {
        let vc = vc
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Extension
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textString = textField.text as NSString? else {
            return false
        }
        
        let text = textString.replacingCharacters(in: range, with: string)
        
        // Enable and Disable Button
        btnLogin?.isUserInteractionEnabled = !text.isEmpty
        if !text.isEmpty {
            btnLogin.setBackgroundImage(UIImage(asset: .buttonBgActive), for: .normal)
        } else {
            btnLogin.setBackgroundImage(UIImage(asset: .buttonBgDisable), for: .normal)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailText:
            passText.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
