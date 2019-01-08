//
//  LoginController.swift
//  projectDemo
//
//  Created by MAC on 1/4/19.
//  Copyright © 2019 Hai Vo L. All rights reserved.
//

import UIKit
import Firebase

final class LoginController: UIViewController {
    
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var loginRegisterButton: UIButton = {
        let b = UIButton()
        b.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        b.setTitle("Register", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        b.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return b
    }()
    
    @objc private func handleLoginRegister() {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            handleRegister()
        }
    }
    
    private func handleLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let this = self else { return }
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            this.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text,
           let name = nameTextField.text else {
            return
        }
        
        // chứng thực authentication
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let userId = user?.uid else { return }
            
            // add firebase
            let ref = Database.database().reference(fromURL: "https://projectdemo-aac9e.firebaseio.com/")
            let userReference = ref.child("users").child(userId)
            let values = ["name": name, "email": email]
            userReference.updateChildValues(values) { [weak self] (error, ref) in
                guard let this = self else { return }
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    return
                }
                this.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // name
    private let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        return tf
    }()
    
    private let nameSeparator: UIView = {
        let v = UIView()
        v.backgroundColor =  UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        return v
    }()
    
    // email
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        return tf
    }()
    
    private let emailSeparator: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        return v
    }()
    
    // password
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // profile
   lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "gameofthrones_splash")
        iv.contentMode = .scaleAspectFill
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    // segment control
    private lazy var loginRegisterSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
        sc.tintColor = .white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc private func handleLoginRegisterChange() {
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
        
        // handle segment control when tap login or register
        containerViewHeightAnchor.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        nameTextFieldHeightAnchor.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:
        loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
        nameTextFieldHeightAnchor.isActive = true
        
        emailTextFieldHeightAnchor.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor.isActive = true
        
        passwordTextFieldHeightAnchor.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor.isActive = true
    }

    // life circle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // handle segment control when tap login or register
    private var containerViewHeightAnchor: NSLayoutConstraint!
    private var nameTextFieldHeightAnchor: NSLayoutConstraint!
    private var emailTextFieldHeightAnchor: NSLayoutConstraint!
    private var passwordTextFieldHeightAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        setupViews()
    }
}

extension LoginController {
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        containerViewHeightAnchor = containerView.heightAnchor.constraint(equalToConstant: 250)
        containerViewHeightAnchor.isActive = true
        
        // add name text field
        containerView.addSubview(nameTextField)
        nameTextField.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: containerView.frame.width, height: 0))
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor.isActive = true
        
        containerView.addSubview(nameSeparator)
        nameSeparator.anchor(top: nameTextField.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, size: .init(width:0, height: 1))
        
        // add email text field
        containerView.addSubview(emailTextField)
        emailTextField.anchor(top: nameSeparator.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: containerView.frame.width, height: 0))
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor.isActive = true
        
        containerView.addSubview(emailSeparator)
        emailSeparator.anchor(top: emailTextField.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, size: .init(width:0, height: 1))
        
        // add passwords
        containerView.addSubview(passwordTextField)
        passwordTextField.anchor(top: emailSeparator.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12), size: .init(width: containerView.frame.width, height: 0))
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor.isActive = true
        
        // add button register
        view.addSubview(loginRegisterButton)
        loginRegisterButton.anchor(top: containerView.bottomAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0),size: CGSize(width: 0, height: 50))
        
        // add segment control
        view.addSubview(loginRegisterSegmentedControl)
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.topAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 12, right: 0), size: .init(width: 0, height: 36))
        
        // add profile image
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.anchor(top: nil, leading: nil, bottom: loginRegisterSegmentedControl.topAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 12, right: 0), size: .init(width: 150, height: 150))
    }
}
