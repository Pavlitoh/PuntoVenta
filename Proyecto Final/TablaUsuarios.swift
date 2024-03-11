//
//  TablaUsuarios.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class TablaUsuarios: NSViewController {
    var nombre: String = ""
    var edad: Int = 0
    var usuario: Int = 0
    var rol: String = ""
    var id: Int32 = 0
    var idUser: Int = 0
    var tipoRol: Int32 = 0
        
        @IBOutlet weak var eliminado: NSTextField!
        @objc dynamic var clientLog: [user]=[]
        var flag: Bool = false
        var index: Int!
        
        override func viewDidLoad() {
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
        
    @IBOutlet weak var Imagen: NSImageView!
    @IBAction func modify(_ sender: NSButton) {
            if clientLog.contains(where: {$0.id == eliminado.integerValue}) {
                let indecs = clientLog.map({$0.id})
                index = indecs.firstIndex(of: eliminado.integerValue)!
                dismiss(self)
                performSegue(withIdentifier: "modifySegue", sender: self)
            }
        }
       
    @IBOutlet weak var txtId: NSTextField!
    
    @IBAction func delete(_ sender: NSButton) {
        
        var index: Int! = 0;
        
        let user = userController.getUserById(Int32(txtId.integerValue));
        if user != nil {
            index = userController.users.firstIndex(of: user!);
            userController.users.remove(at: index);
            if user?.rol == 1 || user?.rol == 4 {
                ventasController.deleteByCliente(user!.id);
            }
            let alertBox = NSAlert()
                        alertBox.messageText  = "Usuario Eliminado"
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
                destinationVC.edad = edad
                destinationVC.usuario = usuario
                destinationVC.rol = rol
                destinationVC.id = id
                destinationVC.tipoRol = tipoRol
            }
        
        if segue.identifier == "modifySegue"
        {
                let destinationVC = segue.destinationController as! viewModificar
                destinationVC.id = txtId.intValue
        }
        }
}
