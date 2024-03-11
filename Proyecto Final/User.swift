//
//  User.swift
//  Proyecto Final
//
//  Created by Cesar Andres Trujillo Ramirez on 08/06/23.
//

import Foundation
import AppKit

class user: NSObject {
    @objc dynamic var id: Int;
    @objc dynamic var nombre: String;
    @objc dynamic var apellidoP: String;
    @objc dynamic var apellidoM: String;
    @objc dynamic var email: String;
    @objc dynamic var telefono: String;
    @objc dynamic var genero: String;
    @objc dynamic var password: String;
    @objc dynamic var rol: Int32;
    @objc dynamic var nombreRol: String;
    @objc dynamic var fechaNacimiento: String;
    @objc dynamic var edad: Int;
    @objc dynamic var color: String;
    @objc dynamic var imagen: String;
    
    func calcularEdad() -> Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if let date = dateFormatter.date(from: fechaNacimiento) {
                let calendar = Calendar.current
                let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
                let age = ageComponents.year ?? 0
                return age
            }
            return 0
        }
    
    init(_ id: Int, _ nombre: String, _ apellidoP: String, _ apellidoM: String, _ email: String, _ telefono: String, _ genero: String, _ password: String, _ rol: Int32, _ fechaNacimiento: String, _ color: String, _ imagen: String) {
        self.id = id
        self.nombre = nombre
        self.apellidoP = apellidoP
        self.apellidoM = apellidoM
        self.email = email
        self.telefono = telefono
        self.genero = genero
        self.password = password
        self.rol = rol;
        self.fechaNacimiento = fechaNacimiento
        self.color = color;
        self.imagen = imagen;
        self.nombreRol = "Cliente";
        if rol == 1 {
            self.nombreRol = "Cliente";
        }
        else if rol == 2 {
            self.nombreRol = "Vendedor";
        }
        else if rol == 3 {
            self.nombreRol = "Comprador";
        }
        else {
            self.nombreRol = "Administrador";
        }
        
        self.edad = 0
    }
    
    func modifyRol(_ rol: Int32) {
        self.rol = rol;
        if rol == 1 {
            self.nombreRol = "Cliente";
        }
        else if rol == 2 {
            self.nombreRol = "Vendedor";
        }
        else if rol == 3 {
            self.nombreRol = "Comprador";
        }
        else {
            self.nombreRol = "Administrador";
        }
    }
}

class UserController: NSObject{
    @objc dynamic var users: [user] = [];
    
    @objc dynamic var idActual: Int = 1;
    
    func addUser(_ nombre: String, _ apellidoP: String, _ apellidoM: String, _ email: String, _ telefono: String, _ genero: String, _ password: String, _ vPassword: String, _ rol: Int32, _ fechaNacimiento: String, _ imagen: String, _ color: String) -> Bool {
            if password == vPassword {
                let newUser = user(idActual, nombre, apellidoP, apellidoM, email, telefono, genero, password, rol, fechaNacimiento, color, imagen);
                newUser.edad = newUser.calcularEdad() // Actualizar la edad después de inicializar el usuario
                users.append(newUser)
                idActual += 1
                print(newUser.edad)
                return true
        }
        return false;
    }
    
    func login(username:String, password:String)
    -> Bool {
        for user in users {
            if user.nombre == username && user.password == password {
                return true
            }
    }
        return false
    }
    
    func getUserById(_ id: Int32) -> user! {
        for usuario in userController.users {
            if usuario.id == id{
                return usuario;
            }
        }
        return nil;
    }
    
    func getColor(_ color: String) -> NSColor {
        switch color {
        case "Rojo":
            return NSColor(red: 1, green: 0.25, blue: 0.25, alpha: 1);
        case "Azul":
            return NSColor(red: 0.25, green: 0.93, blue: 1, alpha: 1);
        case "Morado":
            return NSColor(red: 0.83, green: 0.25, blue: 1, alpha: 1);
        case "Naranja":
            return NSColor(red: 1, green: 0.51, blue: 0.25, alpha: 1);
        default:
            return NSColor(red: 0, green: 0, blue: 0, alpha: 1);
        }
    }
}

