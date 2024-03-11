//
//  TablaProductos.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class TablaProductos: NSViewController {
    var nombre: String = ""
    
    var id: Int32 = 0
    
    var idUser: Int = 0
    
    var act: Int32 = 0
    
    @IBOutlet weak var Registrar: NSButton!
    
    @IBOutlet weak var Imagen: NSImageView!
    @IBOutlet weak var eliminado: NSTextField!
    
    @objc dynamic var productLog: [producto]=[]
    
    var flag: Bool = false
    
    var index: Int!
    
    override func viewDidLoad() {
        productLog = productController.productos;
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true;
        if idUser == 0 {
            Imagen.image = NSImage(named: "Bob Esponja");
            view.layer?.backgroundColor = userController.getColor("Rojo").cgColor;
            return;
        }
        Imagen.image = NSImage(named: userController.getUserById(Int32(idUser)).imagen);
        
        view.layer?.backgroundColor = userController.getColor(userController.getUserById(Int32(idUser)).color).cgColor;
    }
    
    @IBAction func Registrar(_ sender: Any) {
        act = 1
        print(act)
        
        performSegue(withIdentifier:"product", sender: self)
        
    }
    
    @IBAction func modify(_ sender: NSButton) {
        
        if productLog.contains(where: {$0.id == eliminado.integerValue}) {
            
            let indecs = productLog.map({$0.id})
            
            index = indecs.firstIndex(of: eliminado.integerValue)!
            
            dismiss(self)
            
            performSegue(withIdentifier: "product", sender: self)
            
        }
        
    }
    
    
    
    @IBOutlet weak var txtId: NSTextField!
    
    
    
    @IBAction func delete(_ sender: NSButton) {
        
        
        
        var index: Int! = 0;
        
        
        
        if  productController.getProductoById(Int32(txtId.integerValue)) != nil {
            
            index = productController.productos.firstIndex(of: productController.getProductoById(Int32(txtId.integerValue)));
            
            productController.productos.remove(at: index);
            
            let alertBox = NSAlert()
            
            alertBox.messageText  = "Producto Eliminado"
            
            alertBox.alertStyle = .informational
            
            alertBox.addButton(withTitle:"Ok")
            
            alertBox.runModal()
            
        }
        
        dismiss(self);
        
    }
    
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
        
        
        
        if segue.identifier == "deleteSegue"
            
        {
            
            let destinationVC = segue.destinationController as! UserUI
            
            destinationVC.nombre = nombre
            
            destinationVC.id = id
            
        }
        
        
        if segue.identifier == "product"
            
        {
            
            let destinationVC = segue.destinationController as! viewRegistroProducto
            
            destinationVC.act = act
            destinationVC.idUser = idUser;
            
            if act == 0{
                
                let destinationVC = segue.destinationController as! viewRegistroProducto
                
                destinationVC.id = txtId.intValue
            }
        }
    }
}
