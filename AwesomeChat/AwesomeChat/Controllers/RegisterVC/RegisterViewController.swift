//
//  RegisterViewController.swift
//  AwesomeChat
//
//  Created by Vũ Linh on 22/07/2021.
//

import UIKit

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
        
        // Email Text
        let imageEmailTextField = UIImage(asset: .email)
        emailText.iconTextField(image: imageEmailTextField ?? UIImage())
        
        // Password Text
        let imagePassTextField = UIImage(asset: .key)
        passText.iconTextField(image: imagePassTextField ?? UIImage())
        passText.isSecureTextEntry = true
    }
}
