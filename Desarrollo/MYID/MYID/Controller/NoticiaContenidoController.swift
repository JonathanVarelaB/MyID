//
//  NoticiaContenidoController.swift
//  MYID
//
//  Created by MacBookDesarrolloTecno01 on 5/23/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class NoticiaContenidoController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webNoticia: UIWebView!
    @IBOutlet weak var indicadorActividad: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let req = URLRequest(url: URL(string: "https://www.google.co.cr")!)
        self.webNoticia.delegate = self
        self.webNoticia.loadRequest(req)
    }
    
    func webViewDidStartLoad(_ webView : UIWebView) {
        self.indicadorActividad.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView : UIWebView) {
        self.indicadorActividad.stopAnimating()
        self.indicadorActividad.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
