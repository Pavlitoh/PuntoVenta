//
//  UserUI.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class UserUI: NSViewController {
    
    var nombre: String = ""
    var edad: Int = 0
    var usuario: Int = 0
    var rol: String = ""
    var id: Int32 = 0
    var idUser: Int = 0
    var tipoRol: Int32 = 0
    
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
    
    @IBAction func consultar(_ sender: NSButton) {
        performSegue(withIdentifier: "consulta", sender: self)
    }
    
    @IBOutlet weak var Imagen: NSImageView!
    
    @IBOutlet weak var btnAlta: NSButton!
    
    @IBOutlet weak var btnBaja: NSButton!
    
    @IBOutlet weak var btnModificar: NSButton!
    
    @IBOutlet weak var btnConsultar: NSButton!
    
    @IBOutlet weak var lblTextId: NSTextField!
    
    @IBOutlet weak var txtId: NSTextField!
    
  
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
            
            if segue.identifier == "irModificar"
            {
                let destinationVC = segue.destinationController as! viewModificar
                destinationVC.id = txtId.intValue
                print("Modificando...")
            }
           
        
        if segue.identifier == "alta"{
            let destinationVC = segue.destinationController as! viewRegistro
            destinationVC.tipoRol = tipoRol

        }
        
        if segue.identifier == "showSegue"{
            let destinationVC = (segue.destinationController as! TablaUsuarios);
            destinationVC.clientLog = userController.users
            destinationVC.nombre = nombre
            destinationVC.usuario = usuario
            destinationVC.rol = rol
            destinationVC.id = id
            destinationVC.tipoRol = tipoRol
            destinationVC.idUser = idUser;
        }
        }
        
    
    @IBAction func enviarId(_ sender: Any) {
        id = txtId.intValue
        
        dismiss(self)

    }
    
    @IBAction func baja(_ sender: NSButton) {
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
    }
    
    
    @IBAction func consultaTest(_ sender: Any) {
        
        performSegue(withIdentifier: "consultar", sender: self)
    }
}
