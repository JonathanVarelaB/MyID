//
//  NoticiasController.swift
//  MYID
//
//  Created by MacBookDesarrolloTecno01 on 5/23/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class NoticiasController: UITableViewController {

    @IBOutlet weak var menuBoton: UIBarButtonItem!
    var noticias = ["noticia1", "noticia2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.funcionamientoMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticias.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Noticia Cell", for: indexPath) as! NoticiaCell
        cell.viewSeparador.clipsToBounds = false
        cell.viewSeparador.layer.cornerRadius = 10
        cell.viewSeparador.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        //cell.labelCel.text = self.noticias[indexPath.row]
        //cell.imagenCell.image = UIImage(named: self.noticias[indexPath.row])
        // asignar URL a alguna propiedad del boton para poder compartir
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 105.0;
    }

    func funcionamientoMenu(){
        if self.revealViewController() != nil {
            self.menuBoton.target = self.revealViewController()
            self.menuBoton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func compartirNoticia(_ sender: UIButton) {
        // tomar url de sender
        let noticiaURL =  [NSURL(string: "https://www.apple.com")]
        let activityViewController = UIActivityViewController(activityItems: noticiaURL , applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }

    
}
