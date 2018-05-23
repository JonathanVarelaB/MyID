//
//  NoticiasController.swift
//  MYID
//
//  Created by MacBookDesarrolloTecno01 on 5/23/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class NoticiasController: UITableViewController {

    var noticias = ["noticia1", "noticia2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 105.0;
    }

}
