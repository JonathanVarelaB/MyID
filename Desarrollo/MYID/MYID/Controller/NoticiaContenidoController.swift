//
//  NoticiaContenidoController.swift
//  MYID
//
//  Created by MacBookDesarrolloTecno01 on 5/23/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class NoticiaContenidoController: UIViewController {

    @IBOutlet weak var webNoticia: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webNoticia.loadRequest(URLRequest(url: URL(string: "http://www.apple.com")!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
