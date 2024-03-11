//
//  Producto.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Foundation

class producto: NSObject {

        @objc dynamic var id: Int;
        @objc dynamic var nombre: String;
        @objc dynamic var descripcion: String;
        @objc dynamic var unidad: String;
        @objc dynamic var precio: Double;
        @objc dynamic var costo: Double;
        @objc dynamic var categoria: String;
        @objc dynamic var cantidad: Int;
       
        
    init(_ id: Int, _ nombre: String, _ descripcion: String, _ unidad: String, _ precio: Double, _ costo: Double, _ categoria: String, _ cantidad: Int) {
            self.id = id
            self.nombre = nombre
            self.descripcion = descripcion
            self.unidad = unidad
            self.precio = precio
            self.costo = costo
            self.categoria = categoria
            self.cantidad = cantidad;
        }
        
        
    }


class ProductosController: NSObject{
    @objc dynamic var productos: [producto] = [];
    
    @objc dynamic var idActual: Int = 1;
    
    func addProducto(_ nombre: String, _ descripcion: String, _ unidad: String, _ precio: Double, _ costo: Double, _ categoria: String, _ cantidad: Int) -> Bool {
        productos.append(producto(idActual, nombre, descripcion, unidad, precio, costo, categoria, cantidad));
        idActual += 1;
        return true;
    }


func getProductoById(_ id: Int32) -> producto! {
    for product in productController.productos{
        if product.id == id{
            return product;
        }
    }
    return nil;
 }
}
