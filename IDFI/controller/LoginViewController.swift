//
//  ViewController.swift
//  IDFI
//
//  Created by IvánMS on 24/06/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: DesignTextField!
    @IBOutlet weak var passwordTextField: DesignTextField!
    var selectedCert: Certificate!
    var student: Student!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    /* Se oculta el teclado cada que se presione enter o se presiona en otro lugar de la vista*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func loginPressed(_ sender: Any) {
        /* Se valida la existencia de los datos */
        if let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            (!email.isEmpty && !password.isEmpty){
            AuthService.shared.loginUser(email: email, password: password, onComplete: {(message,data) in
                guard message == nil else{
                    self.alert(title: "Error", message: message!)
                    return
                }
                let userId = AuthService.shared.user!.uid
                /* Si no es estudiante se despliega la vista de administrador */
                self.isStudent(userId)
            })
        }else{
            let alert = UIAlertController(title: "Usuario y contraseña incorrectos", message: "Ingrese usuario y contraseña para continuar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert,animated: true)
        }
    }
    func alert(title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    func isStudent(_ userId: String) {
        var std: Bool = false
        DatabaseService.shared.studentRef.observeSingleEvent(of: .value) { (snapshot) in
            var temporal: Student?
            for student in snapshot.children.allObjects as! [DataSnapshot]{
                /* Si el id se encuentra entre los estudiantes, std es verdadero y recupera sus datos */
                let uuid = student.key
                if userId == uuid{
                    std = true
                    if let data = student.value as? [String:AnyObject],
                        let certificateId = data["certId"] as? String,
                        let profile = data["profile"] as? [String:AnyObject],
                        let name = profile["name"] as? String,
                        let lastName = profile["lastName"] as? String,
                        let profileAcademic = profile["profileAcademic"] as? String,
                        let language = profile["language"] as? Bool,
                        let socialService = profile["socialService"] as? Bool,
                        let degreeOption = profile["degreeOption"] as? Bool{
                        
                        temporal = Student(name: name, lastName: lastName, language: language, socialService: socialService, profileAcadem: profileAcademic, certificateId: certificateId,id: uuid, degreeOption: degreeOption)
                    }
                    break
                }
            }
            self.student = temporal
            /* Se despliega la vista dependiendo del tipo de usuario que sea */
            if !std{
                self.diplayViewAdmin()
                return
            }
            self.displayViewStudent()
        }
        
    }
    func diplayViewAdmin() {
        /* Vista que aparece si el usuario autenticado es administrador */
        let generationsNavBar = self.storyboard?.instantiateViewController(withIdentifier: "GenerationsNavigationController") as! UINavigationController
        let generationViewController = generationsNavBar.topViewController as! GenerationsViewController
        
        generationViewController.selectedCert = self.selectedCert
        self.present(generationsNavBar, animated: true, completion: nil)
    }
    func displayViewStudent() {
        /* Si es estudiante se manda a StudentVouchersViewController con sus datos */
        let tabBar = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let nav = tabBar.viewControllers![0] as! UINavigationController
        let StudentVouchersViewController = nav.topViewController as! StudentVouchersViewController
        let ProfileViewController = tabBar.viewControllers![1] as! ProfileViewController
        StudentVouchersViewController.selectedStudent = student
        StudentVouchersViewController.selectedCert = selectedCert
        StudentVouchersViewController.isStudent = true
        ProfileViewController.selectedStudent = student
        present(tabBar, animated: true, completion: nil)
    }
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

