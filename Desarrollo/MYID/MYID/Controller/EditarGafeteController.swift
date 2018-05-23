//
//  EditarGafeteController.swift
//  MYID
//
//  Created by Jonathan Varela on 5/22/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class EditarGafeteController: UIViewController {

    
    @IBOutlet weak var nombreText: UITextField!
    @IBOutlet weak var telefonoText: UITextField!
    @IBOutlet weak var correoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nombreText.underlined()
        self.telefonoText.underlined()
        self.correoText.underlined()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelarBoton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
