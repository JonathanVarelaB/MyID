//
//  RestaurantesController.swift
//  MYID
//
//  Created by MacBookDesarrolloTecno01 on 5/23/18.
//  Copyright © 2018 Jonathan Varela. All rights reserved.
//

import UIKit

class RestaurantesController: UITableViewController {
    
    var restaurantes = ["restaurante1", "restaurante2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurantes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Convenio Cell", for: indexPath) as! ConvenioCell
        
        //cell.labelCel.text = self.noticias[indexPath.row]
        //cell.imagenCell.image = UIImage(named: self.noticias[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80.0;
    }


}
