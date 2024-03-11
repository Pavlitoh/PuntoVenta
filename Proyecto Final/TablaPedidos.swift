//
//  TablaPedidos.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 09/06/23.
//

import Cocoa

class TablaPedidos: NSViewController {
    
    @objc dynamic var pedidoLog: [Pedido]=[]
    var id: Int!;

    @IBOutlet weak var Imagen: NSImageView!
    override func viewDidLoad() {
        for venta in ventasController.ventas {
            let product = productController.getProductoById(Int32(venta.idProducto));
            if id == venta.idCliente {
                pedidoLog.append(Pedido(venta.id, product!.id, product!.nombre, product!.descripcion, product!.unidad, product!.precio, product!.costo, product!.categoria))
            }
        }
        super.viewDidLoad()
        view.wantsLayer = true;
        if id == 0 {
            Imagen.image = NSImage(named: "Bob Esponja");
            view.layer?.backgroundColor = userController.getColor("Rojo").cgColor;
            return;
        }
        Imagen.image = NSImage(named: userController.getUserById(Int32(id)).imagen);
        
        view.layer?.backgroundColor = userController.getColor(userController.getUserById(Int32(id)).color).cgColor;
    }
}

class Pedido: NSObject
{
    @objc dynamic var idPedido: Int = 0;
    @objc dynamic var idProducto: Int = 0;
    @objc dynamic var nombre: String = "";
    @objc dynamic var descripcion: String = "";
    @objc dynamic var unidad: String = "";
    @objc dynamic var precio: Double = 0.0;
    @objc dynamic var costo: Double = 0.0;
    @objc dynamic var categoria: String = "";
    
    init(_ idPedido: Int, _ idProducto: Int, _ nombre: String, _ descripcion: String, _ unidad: String, _ precio: Double, _ costo: Double, _ categoria: String) {
        self.idPedido = idPedido
        self.idProducto = idProducto
        self.nombre = nombre
        self.descripcion = descripcion
        self.unidad = unidad
        self.precio = precio
        self.costo = costo
        self.categoria = categoria
    }
}

