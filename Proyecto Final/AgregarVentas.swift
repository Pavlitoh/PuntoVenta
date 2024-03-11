//
//  AgregarVentas.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Cocoa

class AgregarVentas: NSViewController {

    var idVendedor: Int!;
    var subtotal: Double = 0;
    var total: Double = 0;
    var product: producto!;
    var venta: Venta! = nil;
    var exists = false;
    var prev = 0;
    var cantidad = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        print(idVendedor ?? "No ID");
        
        if venta != nil {
            txtProducto.integerValue = venta.idProducto;
            txtCantidad.integerValue = venta.cantidad;
            txtCliente.integerValue = venta.idCliente;
            prev = venta.cantidad;
            Calcular(self);
        }
        view.wantsLayer = true;
        if idVendedor == 0 {
            Imagen.image = NSImage(named: "Bob Esponja");
            view.layer?.backgroundColor = userController.getColor("Rojo").cgColor;
            return;
        }
        Imagen.image = NSImage(named: userController.getUserById(Int32(idVendedor)).imagen);
        
        view.layer?.backgroundColor = userController.getColor(userController.getUserById(Int32(idVendedor)).color).cgColor;
    }
    
    @IBOutlet weak var Imagen: NSImageView!
    @IBOutlet weak var txtProducto: NSTextField!
    @IBOutlet weak var txtCantidad: NSTextField!
    @IBOutlet weak var txtCliente: NSTextField!
    @IBOutlet weak var txtSubtotal: NSTextField!
    @IBOutlet weak var txtTotal: NSTextField!
    
    @IBAction func Calcular(_ sender: Any) {
        if !Validar() {
            return;
        }
        
        subtotal = product.precio * txtCantidad.doubleValue;
        subtotal = subtotal.rounded(toPlaces: 2);
        total = (subtotal * VentasController.iva).rounded(toPlaces: 2);
        
        txtSubtotal.stringValue = "Subtotal: $\(subtotal)";
        txtTotal.stringValue = "Total: $\(total)";
    }
    
    @IBAction func Subir(_ sender: NSButton) {
        if !Validar() {
            return;
        }
        
        Calcular(sender);
        
        if venta == nil {
            ventasController.create(
                idVendedor,
                txtProducto.integerValue,
                txtCantidad.integerValue,
                subtotal,
                total,
                txtCliente.integerValue);
            Mensaje("Venta Agregada");
        }
        else {
            ventasController.update(
                Int32(venta.id),
                idVendedor,
                txtProducto.integerValue,
                txtCantidad.integerValue,
                subtotal,
                total,
                txtCliente.integerValue, prev);
            Mensaje("Venta Modificada");
        }
    }
    
    func Validar() -> Bool {
        product = productController.getProductoById(txtProducto.intValue);
        if product == nil {
            Mensaje("El producto no existe");
            return false;
        }
        
        if txtCantidad.intValue > product.cantidad + prev {
            Mensaje("Cantidad insuficiente");
            return false;
        }
        
        return true;
    }
    
    func Mensaje(_ txt: String) {
        let alertBox = NSAlert()
        alertBox.messageText  = txt
        alertBox.alertStyle = .informational
        alertBox.addButton(withTitle:"Ok")
        alertBox.runModal()
    }
}

extension Double {
    public func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places));
        return (self * divisor).rounded() / divisor;
    }
}
