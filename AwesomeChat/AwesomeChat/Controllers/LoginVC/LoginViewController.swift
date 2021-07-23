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
    let forgotPassView = ForgotViewController()
    
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
        let imageEmailTextField = UIImage(named: "email")
        emailText.rightView = UIImageView(image: imageEmailTextField) // Add icon textfield
        emailText.rightViewMode = .always
        emailText.addBottomBorder()
        emailText.delegate = self
        
        // Password Text
        let imagePassTextField = UIImage(named: "key")
        passText.rightView = UIImageView(image: imagePassTextField) // Add icon textfield
        passText.rightViewMode = .always
        passText.addBottomBorder()
        passText.delegate = self
    }
    
    // MARK: - Button
    @IBAction private func loginBtn(_ sender: UIButton) {
        guard let email = emailText.text, !email.isEmpty,
              let password = passText.text, !password.isEmpty, password.count >= 6 else {
            alert(title: "Email or Password incorrect!!!", message: "Please check your account!!!")
            emailText.text = ""
            passText.text = ""
            return
        }
        
        // Authentication
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            // Error when no account in DB
            guard error == nil else {
                strongSelf.createAccount()
                return
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
    
    // Show Create Account
    private func createAccount() {
        let alertCreateAcc = UIAlertController(title: "Account does not exist!!!",
                                               message: "Do you want create new account",
                                               preferredStyle: .alert)
        alertCreateAcc.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            self?.changeVC(vc: self?.registerView ?? UIViewController())
        }))
        alertCreateAcc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertCreateAcc, animated: true, completion: nil)
    }
}

// MARK: - Extension
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        // Enable and Disable Button
        if !text.isEmpty {
            btnLogin?.isUserInteractionEnabled = true
            btnLogin.setBackgroundImage(UIImage(named: "ButtonBgActive"), for: .normal)
        } else {
            btnLogin?.isUserInteractionEnabled = false
            btnLogin.setBackgroundImage(UIImage(named: "ButtonBgDisable"), for: .normal)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailText:
            self.passText.becomeFirstResponder()
        default:
            break
        }
        return true
    }
}
