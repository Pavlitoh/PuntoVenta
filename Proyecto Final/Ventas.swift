//
//  Ventas.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Foundation

class Venta: NSObject {
    @objc dynamic var id: Int;
    @objc dynamic var idVendedor: Int;
    @objc dynamic var idProducto: Int;
    @objc dynamic var cantidad: Int;
    @objc dynamic var subtotal: Double;
    @objc dynamic var total: Double;
    @objc dynamic var idCliente: Int;
    
    init(_ id: Int, _ idVendedor: Int, _ idProducto: Int, _ cantidad: Int, _ subtotal: Double, _ total: Double, _ idCliente: Int) {
        self.id = id
        self.idVendedor = idVendedor;
        self.idProducto = idProducto;
        self.cantidad = cantidad;
        self.subtotal = subtotal;
        self.total = total;
        self.idCliente = idCliente;
    }
}

class VentasController: NSObject{
    static var iva: Double = 1.16;
    
    @objc dynamic var ventas: [Venta] = [];
    
    @objc dynamic var idActual: Int = 1;
    
    func create(_ idVendedor: Int, _ idProducto: Int, _ cantidad: Int, _ subtotal: Double, _ total: Double, _ idCliente: Int) {
        ventas.append(Venta(idActual, idCliente, idProducto, cantidad, subtotal, total, idCliente));
        idActual += 1;
        productController.getProductoById(Int32(idProducto)).cantidad = productController.getProductoById(Int32(idProducto)).cantidad - cantidad;
    }
    
    func getById(_ id: Int32) -> Venta! {
        for venta in self.ventas {
            if venta.id == id {
                return venta;
            }
        }
        return nil;
    }
    
    func delete(_ id: Int32) {
        let venta = self.getById(id);
        if venta != nil {
            let index = self.ventas.firstIndex(of: venta!)!;
            productController.getProductoById(Int32(ventas[index].idProducto)).cantidad += ventas[index].cantidad;
            self.ventas.remove(at: index);
        }
    }
    
    func update(_ id: Int32, _ idVendedor: Int, _ idProducto: Int, _ cantidad: Int, _ subtotal: Double, _ total: Double, _ idCliente: Int, _ prev: Int) {
        var index = 0;
        for venta in self.ventas {
            if venta.id == id {
                break;
            }
            index += 1;
        }
        self.ventas[index] = Venta(Int(id), idVendedor, idProducto, cantidad, subtotal, total, idCliente);
        productController.getProductoById(Int32(idProducto)).cantidad = productController.getProductoById(Int32(idProducto)).cantidad + prev - cantidad;
    }
    
    func deleteByCliente(_ idCliente: Int)
    {
        var ids: [Int] = [];
        for venta in self.ventas {
            if venta.idCliente == idCliente {
                ids.append(venta.id);
            }
        }
        for id in ids {
            delete(Int32(id));
        }
    }
}
