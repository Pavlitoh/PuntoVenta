//
//  viewModificar.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class viewModificar: NSViewController, NSComboBoxDelegate, NSComboBoxDataSource {
    var nombre: String = ""
    var apellidoP: String = ""
    var apellidoM: String = ""
    var fechaNacimiento: String = ""
    var email: String = ""
    var telefono: String = ""
    var genero: String = ""
    var rol: String = ""
    var id: Int32 = 0
    var usuario: user!;
    
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

    
    @IBOutlet weak var cmbColor: NSComboBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        cmbImagen.delegate = self;
        cmbColor.delegate = self;
        
        for imagen in imagenes {
            cmbImagen.addItem(withObjectValue: imagen);
        }
        
        for color in colores {
            cmbColor.addItem(withObjectValue: color);
        }
        
        cmbImagen.selectItem(at: 0);
        cmbColor.selectItem(at: 0);
        
        view.wantsLayer = true;
        view.layer?.backgroundColor = userController.getColor(colores[0]).cgColor;
        modificar();
    }
    
    
    @IBOutlet weak var txtNombre: NSTextField!
    @IBOutlet weak var txtApellidoP: NSTextField!
    @IBOutlet weak var txtApellidoM: NSTextField!
    @IBOutlet weak var txtFechaNacimiento: NSTextField!
    @IBOutlet weak var txtEmail: NSTextField!
    @IBOutlet weak var txtTelefono: NSTextField!
    @IBOutlet weak var txtGenero: NSTextField!
    @IBOutlet weak var txtRol: NSTextField!
    @IBOutlet weak var cmbImagen: NSComboBox!
    @IBOutlet weak var Imagen: NSImageView!
    
    func modificar(){
        usuario = userController.getUserById(id);
        
        if usuario != nil {
            txtNombre.stringValue = usuario.nombre
            txtApellidoM.stringValue = usuario.apellidoM
            txtApellidoP.stringValue = usuario.apellidoP
            txtFechaNacimiento.stringValue = usuario.fechaNacimiento
            txtEmail.stringValue = usuario.email
            txtTelefono.stringValue = usuario.telefono
            txtGenero.stringValue = usuario.genero
            txtRol.stringValue = String(usuario.rol)
            
            cmbColor.selectItem(at: colores.firstIndex(of: usuario.color)!);
            view.layer?.backgroundColor = userController.getColor(usuario.color).cgColor;

            cmbImagen.selectItem(at: imagenes.firstIndex(of: usuario.imagen)!);
            Imagen.image = NSImage(named: usuario.imagen);
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
    
    
    @IBAction func btnGuardar(_ sender: Any) {
        usuario.email = txtEmail.stringValue;
        usuario.apellidoM = txtApellidoM.stringValue
        usuario.apellidoP = txtApellidoP.stringValue
        usuario.fechaNacimiento = txtFechaNacimiento.stringValue
        usuario.genero = txtGenero.stringValue
        usuario.nombre = txtNombre.stringValue
        usuario.telefono = txtTelefono.stringValue
        usuario.modifyRol(txtRol.intValue);
        usuario.imagen = imagenes[cmbImagen.indexOfSelectedItem];
    
        let alertBox = NSAlert()
                    alertBox.messageText  = "Usuario modificado"
                    alertBox.alertStyle = .informational
                    alertBox.addButton(withTitle:"Ok")
                    alertBox.runModal()
        
        dismiss(self)
        
    }
}
