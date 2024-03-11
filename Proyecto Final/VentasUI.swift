//
//  VentasUI.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class VentasUI: NSViewController {

    var id: Int!;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true;
        if id == 0 {
            Imagen.image = NSImage(named: "Bob Esponja");
            view.layer?.backgroundColor = userController.getColor("Rojo").cgColor;
            return;
        }
        Imagen.image = NSImage(named: userController.getUserById(Int32(id)).imagen);
        view.layer?.backgroundColor = userController.getColor(userController.getUserById(Int32(id)).color).cgColor;
    }
    
    @IBOutlet weak var txtID: NSTextField!
    @IBOutlet weak var Imagen: NSImageView!
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
        if segue.identifier == "Agregar"{
            let destinationVC = (segue.destinationController as! AgregarVentas);
            destinationVC.idVendedor = id;
        }
        
        if segue.identifier == "Modificar"{
            let destinationVC = (segue.destinationController as! AgregarVentas);
            let venta = ventasController.getById(txtID.intValue);
            destinationVC.venta = venta;
            destinationVC.idVendedor = id;
        }
    }
    
    @IBAction func Modificar(_ sender: NSButton) {
        let venta = ventasController.getById(txtID.intValue);
        if venta == nil {
            Mensaje("La venta no existe");
            return;
        }
        performSegue(withIdentifier: "Modificar", sender: self);
    }
    
    @IBAction func Eliminar(_ sender: NSButton) {
        let venta = ventasController.getById(txtID.intValue);
        if venta == nil {
            Mensaje("La venta no existe");
            return;
        }
        ventasController.delete(txtID.intValue);
        Mensaje("Venta eliminada");
    }
    
    func Mensaje(_ txt: String) {
        let alertBox = NSAlert()
        alertBox.messageText  = txt
        alertBox.alertStyle = .informational
        alertBox.addButton(withTitle:"Ok")
        alertBox.runModal()
    }
}
