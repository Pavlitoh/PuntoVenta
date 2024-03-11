//
//  viewRegistroProducto.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class viewRegistroProducto: NSViewController {

    var nombre: String = ""

    var descripcion: String = ""

    var unidad: String = ""

    var precio: Double = 0

    var costo: Double = 0

    var categoria: String = ""
    
    var cantidad: Int = 0

    var validado: Bool = false

    var act: Int32 = 0

   var id: Int32 = 0
    
   var idUser: Int = 0

   var product: producto!;



override func viewDidLoad() {

    super.viewDidLoad()

    // Do view setup here.

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

@IBOutlet weak var Imagen: NSImageView!
    

func modificar(){

      product = productController.getProductoById(id);
      

      if product != nil {

              txtProducto.stringValue = product.nombre
              txtDescripcion.stringValue = product.descripcion
              txtUnidad.stringValue = product.unidad
              txtPrecio.doubleValue = product.precio
              txtCosto.doubleValue = product.costo
              txtCategoria.stringValue = product.categoria
          txtCantidad.integerValue = product.cantidad;
      print (0)

      }

  }


@IBOutlet weak var txtProducto: NSTextField!

@IBOutlet weak var txtDescripcion: NSTextField!

@IBOutlet weak var txtUnidad: NSTextField!

@IBOutlet weak var txtPrecio: NSTextField!

@IBOutlet weak var txtCosto: NSTextField!

@IBOutlet weak var txtCategoria: NSTextField!

    @IBOutlet weak var txtCantidad: NSTextField!
    

@IBAction func btnGuardar(_ sender: NSButton) {

    Validar()
    print(act)
    
    if(validado == true){
    if(act == 1){
      
            let resultado: Bool =  productController.addProducto(
                
                txtProducto.stringValue,
                
                txtDescripcion.stringValue,
                
                txtUnidad.stringValue,
                
                txtPrecio.doubleValue,
                
                txtCosto.doubleValue,
                
                txtCategoria.stringValue,
                
                txtCantidad.integerValue
                
            );
            
            print(resultado);

            txtProducto.stringValue = nombre
            txtDescripcion.stringValue = descripcion
            txtUnidad.stringValue = unidad
            txtPrecio.doubleValue = precio
            txtCosto.doubleValue = costo
            txtCategoria.stringValue = categoria
            txtCantidad.integerValue = cantidad;

            let alertBox = NSAlert()
            
            alertBox.messageText  = "Producto registrdo con éxito"
            
            alertBox.alertStyle = .informational
            
            alertBox.addButton(withTitle:"Ok")
            
            alertBox.runModal()
            
            dismiss(self)
            
        }
        else{
            
          
        
            product.nombre = txtProducto.stringValue;

            product.descripcion = txtDescripcion.stringValue

            product.unidad = txtUnidad.stringValue

            product.precio = txtPrecio.doubleValue

            product.costo = txtCosto.doubleValue

            product.categoria = txtCategoria.stringValue
            
            product.cantidad = txtCantidad.integerValue

        

            let alertBox = NSAlert()

                        alertBox.messageText  = "Producto modificado"

                        alertBox.alertStyle = .informational

                        alertBox.addButton(withTitle:"Ok")

                        alertBox.runModal()

        }
        
      dismiss(self)

    }

   

}



func Validar(){

    if ( txtProducto.stringValue == "" ||

            txtDescripcion.stringValue == "" ||

            txtUnidad.stringValue == "" ||

            txtPrecio.stringValue == "" ||

            txtCosto.stringValue == "" ||

            txtCategoria.stringValue == "" ||
         
         txtCantidad.stringValue == "")

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
