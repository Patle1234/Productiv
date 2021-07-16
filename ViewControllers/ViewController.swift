//
//  ViewController.swift
//  Productiv
//
//  Created by Dev Patel on 7/9/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    func setUpElements(){
        Utilities.styleFilledButton(loginBtn)
        Utilities.styleFilledButton(signUpBtn)
    }


}
