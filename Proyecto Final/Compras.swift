//
//  Compras.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 09/06/23.
//

import Foundation

class compritas: NSObject {

        @objc dynamic var id: Int;
        @objc dynamic var idProducto: Int;
        @objc dynamic var producta: String;
        @objc dynamic var cantidad: Int;
        @objc dynamic var idComprador: Int;
        @objc dynamic var info: String;
       
        
    init(_ id: Int, _ idProducto: Int, _ producta: String, _ cantidad: Int, _ idComprador: Int, _ info: String) {
            self.id = id
            self.idProducto = idProducto
            self.producta = producta
            self.cantidad = cantidad
            self.idComprador = idComprador
            self.info = info
            
         
        }
        
        
    }


class ComprasController: NSObject{
    @objc dynamic var productos: [compritas] = [];
    
    @objc dynamic var idActual: Int = 1;
    
    func addProducto(_ idProducto: Int, _ producta: String, _ cantidad: Int, _ idComprador: Int, _ info: String) -> Bool {
        productos.append(compritas(idActual, idProducto, producta, cantidad, idComprador, info));
        productController.getProductoById(Int32(idProducto)).cantidad += cantidad;
        idActual += 1;
        return true;
    }


func getProductoById(_ id: Int32) -> compritas! {
    for product in comprasController.productos {
        if product.id == id{
            return product;
        }
    }
    return nil;
 }
}

