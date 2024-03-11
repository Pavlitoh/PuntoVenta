//
//  TablaCompras.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 09/06/23.
//

import Cocoa

class TablaCompras: NSViewController {

    var nombre: String = ""
    
    var id: Int = 0
    var idUser: Int = 0
    
    var act: Int32 = 0
    
    @IBOutlet weak var Registrar: NSButton!
    
    @IBOutlet weak var Imagen: NSImageView!
    
    @IBOutlet weak var eliminado: NSTextField!
    
    @objc dynamic var comprasLog: [compritas]=[]
    
    var flag: Bool = false
    
    var index: Int!
    
    
    
    override func viewDidLoad() {
        comprasLog = comprasController.productos
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
        
        performSegue(withIdentifier:"xd", sender: self)
        
    }
    
    @IBAction func modify(_ sender: NSButton) {
        
        if comprasLog.contains(where: {$0.id == eliminado.integerValue}) {
            
            let indecs = comprasLog.map({$0.id})
            
            index = indecs.firstIndex(of: eliminado.integerValue)!
            
            dismiss(self)
            act = 0;
            
            performSegue(withIdentifier: "xd", sender: self)
            
        }
        
    }
    
    
    
    @IBOutlet weak var txtId: NSTextField!
    
    
    
    @IBAction func delete(_ sender: NSButton) {
        
        
        
        var index: Int! = 0;
        
        
        
        if  comprasController.getProductoById(Int32(txtId.integerValue)) != nil {
            
            index = comprasController.productos.firstIndex(of: comprasController.getProductoById(Int32(txtId.integerValue)));
            
            comprasController.productos.remove(at: index);
            
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
            
            destinationVC.id = Int32(id)
            
        }
        
        
        if segue.identifier == "xd"
            
        {
            
            let destinationVC = segue.destinationController as! registroCompra
            
            destinationVC.act = act
            destinationVC.idUser = idUser;
            
            if act == 0{
                
                let destinationVC = segue.destinationController as! registroCompra
                
                destinationVC.id = txtId.intValue
            }
        }
    }
}
