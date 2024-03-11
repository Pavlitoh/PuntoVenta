//
//  registroCompra.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 09/06/23.
//

import Cocoa

class registroCompra: NSViewController {

    var nombre: String = ""

    var descripcion: String = ""

    var unidad: String = ""

    var precio: Double = 0

    var costo: Double = 0

    var categoria: String = ""

    var validado: Bool = false

    var act: Int32 = 0

    var id: Int32 = 0

    var product: compritas!;
    
    var idUser: Int!;
    
    var prev: Int = 0;



    @IBOutlet weak var Imagen: NSImageView!
    override func viewDidLoad() {
    super.viewDidLoad()

    // Do view setup here.
    
    txtComprador.isHidden = false
    txtIdProducto.isHidden = false
    
    txtPrecio.isHidden = false
    txtProducto.isHidden = false
    txtProducto.isHidden = false
    
    txtDescripcion.isHidden = true
    txtDescripcion.stringValue = "1"
    txtCosto.isHidden = true
    txtCosto.stringValue = "1"

    if(act == 0){
        modificar()
    }

        
    view.wantsLayer = true;
    if idUser == 0 {
        Imagen.image = NSImage(named: "Bob Esponja");
        view.layer?.backgroundColor = userController.getColor("Rojo").cgColor;
        return;
    }
    Imagen.image = NSImage(named: userController.getUserById(Int32(idUser)).imagen);
        
        view.layer?.backgroundColor = userController.getColor(userController.getUserById(Int32(idUser)).color).cgColor;
}



func modificar(){
    txtComprador.isHidden = true
    txtIdProducto.isHidden = true
    txtCosto.isHidden = true
    txtPrecio.isHidden = true
    txtProducto.isHidden = true
    txtProducto.isHidden = true
    txtDescripcion.isHidden = true
    
      product = comprasController.getProductoById(id);
      

      if product != nil {

              txtProducto.integerValue = product.idProducto
              txtDescripcion.stringValue = product.producta
              txtUnidad.integerValue = product.cantidad
              txtPrecio.integerValue = product.idComprador
              txtCosto.stringValue = product.info
          prev = product.cantidad;
      }

  }



@IBOutlet weak var txtProducto: NSTextField!

@IBOutlet weak var txtDescripcion: NSTextField!

@IBOutlet weak var txtUnidad: NSTextField!

@IBOutlet weak var txtPrecio: NSTextField!
@IBOutlet weak var txtCosto: NSTextField!

@IBOutlet weak var txtComprador: NSTextField!
@IBOutlet weak var txtIdProducto: NSTextField!
    
    


@IBAction func btnGuardar(_ sender: NSButton) {

    Validar()
    print(act)
    
    if(validado == true){

    if(act == 1){
        
        if(userController.getUserById(txtPrecio.intValue ) == nil){
            
            let alertBox = NSAlert()
            alertBox.messageText  = "Usuario no encontrado."
            alertBox.alertStyle = .informational
            alertBox.addButton(withTitle:"Ok")
            alertBox.runModal()
            return
        }
        
        if(userController.getUserById(txtPrecio.intValue).rol != 3 &&
           userController.getUserById(txtPrecio.intValue).rol != 4 )
        {
            let alertBox = NSAlert()
            alertBox.messageText  = "El usuario no tiene permisos para hacer una compra."
            alertBox.alertStyle = .informational
            alertBox.addButton(withTitle:"Ok")
            alertBox.runModal()
            return
            
        }
        
        
            let resultado: Bool =  comprasController.addProducto(
                
                txtProducto.integerValue,
                
                productController.getProductoById(txtProducto.intValue).nombre,
                
                txtUnidad.integerValue,
                
                txtPrecio.integerValue,
                
                userController.getUserById(txtPrecio.intValue).nombre
                
            );
   
            print(resultado);
            
            
            txtProducto.stringValue = nombre
            
            txtDescripcion.stringValue = descripcion
            
            txtUnidad.stringValue = unidad
            
            txtPrecio.doubleValue = precio
            
            txtCosto.doubleValue = costo
            
            
            
            let alertBox = NSAlert()
            
            alertBox.messageText  = "Compra registrada con éxito"
            
            alertBox.alertStyle = .informational
            
            alertBox.addButton(withTitle:"Ok")
            
            alertBox.runModal()
            
            
        }
        else{
            
            if productController.getProductoById(Int32(product.idProducto)).cantidad - prev + txtUnidad.integerValue < 0 {
                    let alertBox = NSAlert()
                    
                    alertBox.messageText  = "La cantidad del producto quedaria negativa"
                    
                    alertBox.alertStyle = .informational
                    
                    alertBox.addButton(withTitle:"Ok")
                    
                    alertBox.runModal()
                    
                    return;
            }
            
            product.idProducto = txtProducto.integerValue

            product.producta = txtDescripcion.stringValue

            product.cantidad = txtUnidad.integerValue;
            
            productController.getProductoById(Int32(product.idProducto)).cantidad = productController.getProductoById(Int32(product.idProducto)).cantidad - prev + txtUnidad.integerValue;

            product.idComprador = txtPrecio.integerValue

            product.info = txtCosto.stringValue

            

        

            let alertBox = NSAlert()

                        alertBox.messageText  = "Compra modificada"

                        alertBox.alertStyle = .informational

                        alertBox.addButton(withTitle:"Ok")

                        alertBox.runModal()

        }
        
      dismiss(self)

    }

}



func Validar(){

    if ( txtProducto.integerValue == 0 ||


            txtUnidad.stringValue == "" ||

            txtPrecio.integerValue == 0
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
        print(validado)

    }

}
}
