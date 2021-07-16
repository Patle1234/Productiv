//
//  LoginViewController.swift
//  Productiv
//
//  Created by Dev Patel on 7/6/21.
//
    import UIKit


class LoginViewController: UIViewController {
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }


    @IBAction func loginClicked(_ sender: Any) {
    }
    
    func setUpElements(){
        Utilities.styleTextField(firstNameTxtField)
        Utilities.styleTextField(lastNameTxtField)
        Utilities.styleFilledButton(loginBtn)
    }
}
