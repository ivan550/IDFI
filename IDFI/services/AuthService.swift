//
//  AuthService.swift
//  IDFI
//
//  Created by IvánMS on 29/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errorMessage: String?,_ data: AnyObject?) -> Void

class AuthService{
    private static let _shared = AuthService()
    
    static var shared: AuthService{
        return _shared
    }
    var user: User? {
        return Auth.auth().currentUser
    }
    
    func loginUser(email: String, password: String, onComplete: Completion?) {
        /* Mètodo signIn para iniciar sesión */
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                print("Usuario autenticado")
                let user = Auth.auth().currentUser
                if let user = user{
                    onComplete?(nil,user)
                    DatabaseService.shared.saveStudent(uuid: user.uid)
                    print("********************************")
                    print(user.uid)
                }
            }else {
                /* Si existe algún error se manejará */
                guard let error = (error as NSError?) else{
                    print("Tú eres el error en sesión!!")
                    return
                }
                self.handleError(error: error,onComplete: onComplete)
            }
        }
        
    }
    func registerUser(email: String, password: String, onComplete: Completion?) {
        
        
        /* Si no existe se registra */
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil{
                print("Registrado")
                //                        DatabaseService.shared.saveStudent(uui: user?.uuid)
            }else{
                if let error = (error as NSError?){
                    print(error)
                    self.handleError(error: error, onComplete: onComplete)
                }
            }
            
        }
    }
    func handleError(error: NSError, onComplete: Completion?){
        if let errorCode = AuthErrorCode(rawValue: error.code){
            switch(errorCode){
            case .invalidEmail:
                onComplete?("Email incorrecto", nil)
                
            case .wrongPassword, .invalidCredential, .accountExistsWithDifferentCredential:
                onComplete?("Contraseña incorrecta", nil)
                
            case .userDisabled:
                onComplete?("Este usuario no tiene permisos para entrar", nil)
                
            case .emailAlreadyInUse:
                onComplete?("No se ha podido crear la cuenta. Este email ya está registrado", nil)
                
            case .weakPassword:
                onComplete?("Contraseña demasiado débil. Añade números y letras", nil)
            case .userNotFound:
                onComplete?("El usuario no existe. Por favor hacer pre-registro",nil)
            case .networkError:
                onComplete?("Su iphone no se puede conectar a internet",nil)
            default:
                onComplete?("Ha habido un problema para entrar. Prueba de nuevo. \(error.localizedDescription)", nil)
            }
        }
    }
}
