//
//  GafeteController.swift
//  MYID
//
//  Created by Jonathan Varela on 5/22/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class GafeteController: UIViewController {

    
    @IBOutlet weak var viewContacto: UIView!
    @IBOutlet weak var fotoGafete: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fotoGafete.layer.masksToBounds = true
        
        self.viewContacto.clipsToBounds = false
        self.viewContacto.layer.cornerRadius = 40
        self.viewContacto.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
