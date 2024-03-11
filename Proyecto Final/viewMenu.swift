//
//  viewMenu.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class viewMenu: NSViewController {
    var nombre: String = ""
    var edad: Int = 0
    var usuario: Int = 0
    var rol: String = ""
    var id: Int32 = 0
    var tipoRol: Int32 = 0
    var idUser: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true;
            lblbv.stringValue = "Bienvenido \(nombre)! :)"
            lblRol.stringValue = "\(rol)"
            activar()
        if idUser == 0 {
            Imagen.image = NSImage(named: "Bob Esponja");
            view.layer?.backgroundColor = userController.getColor("Rojo").cgColor;
            return;
        }
        Imagen.image = NSImage(named: userController.getUserById(Int32(idUser)).imagen);
        
        view.wantsLayer = true;
        view.layer?.backgroundColor = userController.getColor(userController.getUserById(Int32(idUser)).color).cgColor;
    }
    
    
    @IBOutlet weak var Imagen: NSImageView!
    @IBOutlet weak var lblbv: NSTextField!
    
    @IBOutlet weak var lblRol: NSTextField!
    
    @IBOutlet weak var btnPedidos: NSButton!
    
    @IBOutlet weak var btnVentas: NSButton!
    @IBOutlet weak var btnCompras: NSButton!
    @IBOutlet weak var btnProductos: NSButton!
    @IBOutlet weak var btnUsuarios: NSButton!
    
    func activar (){
        
        if(tipoRol == 1){
            btnVentas.isHidden = true
            btnCompras.isHidden = true
            btnUsuarios.isHidden = true
            btnProductos.isHidden = true
        }
        else if(tipoRol == 2){
            btnPedidos.isHidden = true
            btnCompras.isHidden = true
            btnUsuarios.isHidden = true
            btnProductos.isHidden = true
        }
        else if(tipoRol == 3){
            btnVentas.isHidden = true
            btnPedidos.isHidden = true
            btnUsuarios.isHidden = true
            
        }
        else{
            
        }
            
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
        if segue.identifier == "goVentas"{
            let destinationVC = (segue.destinationController as! VentasUI);
            destinationVC.id = idUser;
        }
        if segue.identifier == "goCompras"{
            let destinationVC = (segue.destinationController as! TablaCompras);
            destinationVC.idUser = idUser;
        }
        if segue.identifier == "goUsers"{
            let destinationVC = (segue.destinationController as! UserUI);
            destinationVC.idUser = idUser;
        }
        if segue.identifier == "goPedidos" {
            let destinationVC = (segue.destinationController as! TablaPedidos);
            destinationVC.id = idUser;
        }
        if segue.identifier == "goProductos" {
            let destinationVC = (segue.destinationController as! TablaProductos);
            destinationVC.idUser = idUser;
        }
    }
}
