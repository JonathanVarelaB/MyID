//
//  testcontroller.swift
//  MYID
//
//  Created by MacBookDesarrolloTecno01 on 5/24/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class testcontroller: UIViewController {

    @IBOutlet weak var prueba: UITextField!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pruebaactudato(_ sender: UITextField) {
        label.text = prueba.text
    }
    @IBAction func cambioText(_ sender: UITextField) {
    label.text = prueba.text
    }
    
    
    
    
    @IBAction func botonprueba(_ sender: UIButton) {
        //print(prueba.text)
        label.text = prueba.text
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
