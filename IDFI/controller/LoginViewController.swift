//
//  ViewController.swift
//  IDFI
//
//  Created by IvánMS on 24/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: DesignTextField!
    @IBOutlet weak var passwordTextField: DesignTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /* Se oculta el teclado cada que se presione enter o se presiona en otro lugar de la vista*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func pressedRegisterBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "showRegister", sender: nil)
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func loginPressed(_ sender: Any) {
        if let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            (!email.isEmpty && !password.isEmpty){
            AuthService.shared.loginUser(email: email, password: password)
        }else{
            let alert = UIAlertController(title: "Usuario y contraseña incorrectos", message: "Ingrese usuario y contraseña para continuar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }

    
}

