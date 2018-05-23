//
//  LoginController.swift
//  MYID
//
//  Created by Jonathan Varela on 5/19/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var identificacionText: UITextField!
    @IBOutlet weak var claveText: UITextField!
    @IBOutlet weak var recordarSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.identificacionText.underlined()
        self.claveText.underlined()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func ingresar(_ sender: UIButton) {
        print("\(self.identificacionText.text) \(self.claveText.text) \(self.recordarSwitch.isOn)")
    }
    
}

extension UITextField {
    func underlined(){
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 51.0/255, green: 102.0/255, blue: 153.0/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

