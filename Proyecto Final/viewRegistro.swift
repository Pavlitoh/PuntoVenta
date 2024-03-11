//
//  viewRegistro.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class viewRegistro: NSViewController, NSComboBoxDelegate, NSComboBoxDataSource {
    var nombre: String = ""
    var apellidoP: String = ""
    var apellidoM: String = ""
    var fechaNacimiento: String = ""
    var email: String = ""
    var telefono: String = ""
    var genero: String = ""
    var tipoRol: Int32 = 2
    var validado: Bool = false
    var rolDef: Int32 = 0
    let imagenes: [String] = [
        "Alien",
        "Bob Esponja",
        "Hatsune Miku",
        "Hello Kitty"
    ];
    let colores: [String] = [
        "Azul",
        "Morado",
        "Naranja",
        "Rojo"
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if tipoRol == 2 {
            txtRol.isHidden = true
            lblRol.isHidden = true
        }
        
        cmbImagen.delegate = self;
        cmbColor.delegate = self;
        
        for imagen in imagenes {
            cmbImagen.addItem(withObjectValue: imagen);
        }
        
        for color in colores {
            cmbColor.addItem(withObjectValue: color);
        }
        
        view.wantsLayer = true;
        userController.getColor(colores[0]).cgColor;
        
        cmbImagen.selectItem(at: 0);
        cmbColor.selectItem(at: 0);
        
    }
    
    @IBOutlet weak var txtUser: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    @IBOutlet weak var txtPaterno: NSTextField!
    @IBOutlet weak var txtMaterno: NSTextField!
    @IBOutlet weak var txtFechaNacimiento: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtGenero: NSTextField!
    @IBOutlet weak var txtVerificar: NSTextField!
    @IBOutlet weak var lblRol: NSTextField!
    @IBOutlet weak var txtRol: NSTextField!
    @IBOutlet weak var cmbImagen: NSComboBox!
    @IBOutlet weak var Imagen: NSImageView!
  
    @IBOutlet weak var cmbColor: NSComboBox!
    
    @IBAction func btnCrearCuenta(_ sender: NSButton) {
        
        Validar()
        
        if(tipoRol == 2){
            rolDef = 1
        }
        else{
            rolDef = txtRol.intValue;
        }
        
        
        if(validado == true){
            let resultado: Bool = userController.addUser(txtUser.stringValue,
                                    txtPaterno.stringValue,
                                    txtMaterno.stringValue,
                                    txtEmail.stringValue,
                                    txtTelefono.stringValue,
                                    txtGenero.stringValue,
                                    txtPassword.stringValue,
                                    txtVerificar.stringValue,
                                    rolDef,
                                    txtFechaNacimiento.stringValue,
                                    imagenes[cmbImagen.indexOfSelectedItem],
                                    colores[cmbColor.indexOfSelectedItem]);
            
            
            print(resultado);
            
            txtUser.stringValue = "";
            txtPassword.stringValue = "";
            txtVerificar.stringValue = ""
            txtRol.stringValue = ""
            txtEmail.stringValue = email
            txtGenero.stringValue = genero
            txtFechaNacimiento.stringValue = fechaNacimiento
            txtMaterno.stringValue = apellidoM
            txtPaterno.stringValue = apellidoP
            txtTelefono.stringValue = telefono
            txtUser.stringValue = nombre
            
            let alertBox = NSAlert()
                        alertBox.messageText  = "Usuario agregado con éxito"
                        alertBox.alertStyle = .informational
                        alertBox.addButton(withTitle:"Ok")
                        alertBox.runModal()
            
          dismiss(self)
        }
       
    }
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if cmbImagen == notification.object as? NSComboBox {
            Imagen.image = NSImage(named: imagenes[cmbImagen.indexOfSelectedItem]);
        }
        else if cmbColor == notification.object as? NSComboBox {
            view.layer?.backgroundColor = userController.getColor(colores[cmbColor.indexOfSelectedItem]).cgColor;
        }
    }
    
  
    func Validar(){
        
        if(tipoRol == 2){
            if(txtUser.stringValue == "" ||
               txtPaterno.stringValue == "" ||
               txtMaterno.stringValue == "" ||
               txtFechaNacimiento.stringValue == "" ||
               txtEmail.stringValue == "" ||
               txtTelefono.stringValue == "" ||
               txtGenero.stringValue == "" ||
               txtPassword.stringValue == "" ||
               txtVerificar.stringValue == ""
               )
            {
                
                let alertBox = NSAlert()
                            alertBox.messageText  = "Campos incompletos."
                            alertBox.alertStyle = .informational
                            alertBox.addButton(withTitle:"Ok")
                            alertBox.runModal()
                
            }
            else{
                validado = true
            }
        }
        else{
            if(txtUser.stringValue == "" ||
               txtPaterno.stringValue == "" ||
               txtMaterno.stringValue == "" ||
               txtFechaNacimiento.stringValue == "" ||
               txtEmail.stringValue == "" ||
               txtTelefono.stringValue == "" ||
               txtGenero.stringValue == "" ||
               txtPassword.stringValue == "" ||
               txtVerificar.stringValue == "" ||
               txtRol.stringValue == "")
            {
                
                let alertBox = NSAlert()
                            alertBox.messageText  = "Campos incompletos."
                            alertBox.alertStyle = .informational
                            alertBox.addButton(withTitle:"Ok")
                            alertBox.runModal()
                
            }
            else{
                validado = true
            }
        }
        
    }
}
