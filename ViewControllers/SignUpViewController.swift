//
//  SignUpViewController.swift
//  Productiv
//
//  Created by Dev Patel on 7/6/21.
//

import UIKit

class SignUpViewController:
    UIViewController {
    
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
    }
    
    func setUpElements(){
        Utilities.styleTextField(firstNameTxtField)
        Utilities.styleTextField(lastNameTxtField)
        Utilities.styleTextField(emailTxtField)
        Utilities.styleTextField(passwordTxtField)
        Utilities.styleFilledButton(signUpBtn)
    }
}
