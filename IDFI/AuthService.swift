//
//  AuthService.swift
//  IDFI
//
//  Created by IvánMS on 29/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import Foundation
import FirebaseAuth
class AuthService{
    private static let _shared = AuthService()
    
    static var shared: AuthService{
        return _shared
    }
    func loginUser(email: String, password: String) {
        // Mètodo signIn para iniciar sesión
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("Usuario autenticado")
            }else {
                /* Error cachará todo tipo de error como por ej. que ya exista el usuario */
                if let error = error?.localizedDescription{
                    print("Error al iniciar sesión con firebase",error)
                }else{
                    print("Tú eres el error en sesión!!")
                }
            }
        }
        
    }
}
