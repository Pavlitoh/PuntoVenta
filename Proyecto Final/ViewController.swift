//
//  ViewController.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

let userController = UserController();
let productController = ProductosController();
let ventasController = VentasController();
let comprasController = ComprasController();

class ViewController: NSViewController {
    var nombre: String = ""
    var tusuario: Int = 0
    var tipoRol: Int32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userController.addUser("Barry", "West", "Allen", "ba@gmail.com", "4771234567", "masculino", "123", "123", 4, "2003-11-28", "Hatsune Miku", "Rojo");
        userController.addUser("Nora", "West", "Allen", "na@gmail.com", "4777654321", "femenino", "123", "123", 4, "2003-10-11", "Alien", "Azul");
        productController.addProducto("Mando", "Xbox", "Piezas", 999.99, 799.89, "Juegos", 3);
        productController.addProducto("Consola", "Play", "Piezas", 1999.99, 1799.89, "Juegos", 5);
        comprasController.addProducto(1, "Mando", 4, 1, "Barry");
        ventasController.create(0, 1, 2, 12, 13, 1);
        ventasController.create(0, 2, 3, 13, 14, 2);
   }
 
    @IBOutlet weak var txtUser: NSTextField!
    @IBOutlet weak var txtPassword: NSTextField!
    
    
    @IBAction func iniciarSesion(_ sender: Any) {
        let loginResult = userController.login(username: txtUser.stringValue, password: txtPassword.stringValue);
        var usuario: user!;
        for user in userController.users {
            if user.nombre == txtUser.stringValue && user.password == txtPassword.stringValue {
                usuario = user;
                break;
            }
        }
        
        nombre = txtUser.stringValue
        
        if( txtUser.stringValue == "" || txtPassword.stringValue == ""){
            // Campos incompletos
        }
        else{
            if (txtUser.stringValue == "admin" && txtPassword.stringValue == "admin123" || (loginResult && usuario.rol == 4)){
                tusuario = 1
                tipoRol = 4
                performSegue(withIdentifier:"ir", sender: self)
                dismiss(self)
               
            }
            else{
                
                
                if(loginResult){
                    tipoRol = usuario.rol
                    performSegue(withIdentifier:"ir", sender: self)
                    dismiss(self)
                }else{
                    // Datos incorrectos
                }
            }
        }
       
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?){
            
            if segue.identifier == "ir"
            {
                let destinationVC = segue.destinationController as! viewMenu
                destinationVC.nombre
                = nombre
                destinationVC.tipoRol
                = tipoRol
                
                
                destinationVC.rol = "Administrador";

                
                for user in userController.users {
                    if user.nombre == nombre && txtPassword.stringValue == user.password {
                        destinationVC.rol = user.nombreRol;
                        destinationVC.idUser = user.id;
                        break;
                    }
                }
             
            }
        }
}

