//
//  SignUpViewController.swift
//  Messages
//
//  Created by Consultant on 8/2/22.
//

import UIKit
import BaronTalk

class SignUpViewController: UIViewController {

    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var txtEmail: UITextField = {
        let txtEmail = UITextField()
        txtEmail.translatesAutoresizingMaskIntoConstraints = false
        txtEmail.heightAnchor.constraint(equalToConstant: 44).isActive = true
        txtEmail.placeholder = "Email"
      
        return txtEmail
      }()
    lazy var txtConfirmEmail: UITextField = {
        let txtConfirmEmail = UITextField()
        txtConfirmEmail.translatesAutoresizingMaskIntoConstraints = false
        txtConfirmEmail.heightAnchor.constraint(equalToConstant: 44).isActive = true
        txtConfirmEmail.placeholder = "Confirm Email"
          
        return txtConfirmEmail
      }()
    
    lazy var txtPassword: UITextField = {
        let txtPassword = UITextField()
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
        txtPassword.heightAnchor.constraint(equalToConstant: 44).isActive = true
        txtPassword.placeholder = "Password"
        txtPassword.isSecureTextEntry = true
          
        return txtPassword
      }()
    
    lazy var btnSignUp: UIButton = {
        let btnSignUp = UIButton(frame: .zero)
        btnSignUp.translatesAutoresizingMaskIntoConstraints = false
        btnSignUp.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnSignUp.setTitle("Sign Up", for: .normal)
        btnSignUp.setTitleColor(.white, for: .normal)
        btnSignUp.layer.cornerRadius = 3
        btnSignUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btnSignUp.addTarget(self, action: #selector(btnRegisterUser), for: .touchUpInside)

        return btnSignUp
       }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.setContentHuggingPriority(.required, for: .vertical)
        label.text = "Error"
        label.textColor = .systemRed
          
          return label
      }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        self.setupTopView()
        self.setUpUI()
        self.setUpElements()
    }
    
    func setUpElements(){
        self.errorLabel.alpha = 0
        
        Utilities.styleTextField(self.txtEmail)
        Utilities.styleTextField(self.txtConfirmEmail)
        Utilities.styleTextField(self.txtPassword)
        Utilities.styleFilledButton(self.btnSignUp)
    }
    
    func setupTopView() {
            
        view.addSubview(topView)

        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func setUpUI(){

        let vStackView = UIStackView()
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 15
        vStackView.axis = .vertical
        vStackView.distribution = .fill
           
           
        vStackView.addArrangedSubview(self.txtEmail)
        vStackView.addArrangedSubview(self.txtConfirmEmail)
        vStackView.addArrangedSubview(self.txtPassword)
        vStackView.addArrangedSubview(self.errorLabel)
        vStackView.addArrangedSubview(self.btnSignUp)
         
        view.addSubview(vStackView)
        
        
        vStackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
        vStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        vStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
       // vStackView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        
       }
    func validateFields() -> result?{
        var data: result?
        
        if txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) != txtConfirmEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines){
         
            data = result(msg: "email doest'n match", status: false)
        }
        
        let cleanedPassword = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
         
            data = result(msg: "Please make sure your password is at least 8 characters, contains a special character and number", status: false)
        }
        
        return data
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func showLogIn(){
        let vc = LogInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func btnRegisterUser(){
        let error = validateFields()

        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        guard (error?.status) != false else {
            self.showError(error?.message ?? "")
              return
        }

        let email = txtEmail.text ?? "", password = txtPassword.text ?? ""
        AuthHandler.createUser(with: email, password: password) { (results) in
            self.showLogIn()
        }
        
    }
}


