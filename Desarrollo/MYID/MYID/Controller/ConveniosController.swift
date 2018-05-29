//
//  ConveniosController.swift
//  MYID
//
//  Created by Jonathan Varela on 5/28/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class ConveniosController: UITabBarController {
    
    @IBOutlet weak var menuBoton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.funcionamientoMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func funcionamientoMenu(){
        if self.revealViewController() != nil {
            self.menuBoton.target = self.revealViewController()
            self.menuBoton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
