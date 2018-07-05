//
//  StudentFormView.swift
//  IDFI
//
//  Created by IvánMS on 04/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit


import UIKit

class StudenFormView: UIView {
    //    public var user: User? {
    //        didSet { updateView() }
    //    }
    let constraintConstant: (left: CGFloat,right: CGFloat) = (left: 30, right: -30)
    let componentHeight: CGFloat = 30
    func getFieldPicker() -> UITextField {
        return profileField
    }
    func getNameField() ->  UITextField{
        return nameField
    }
    func getLastNameField() ->  UITextField{
        return lastNameField
    }
    func getSendBtn() -> UIButton{
        return sendBtn
    }
//    private let avatar: UIImageView = {
//        let view = UIImageView(image: #imageLiteral(resourceName: "user"))
//        view.contentMode = .scaleAspectFill
//        view.clipsToBounds = true
//        view.layer.borderWidth = 5
//        view.layer.borderColor = UIColor.gray.cgColor
//        view.layer.cornerRadius = 112
//
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
//    let navBar: UINavigationBar = {
//        let nav = UINavigationBar()
//        return nav
//    }()
    
    /* Labels: nombre, apellido, perfil del alumno, */
    let nameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.textAlignment = .left
        lbl.text = "Nombre"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let lastNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.textAlignment = .left
        lbl.text = "Apellidos"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let profileLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.textAlignment = .left
        lbl.text = "Perfil del alumno"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    private let certificationLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .light)
        lbl.textAlignment = .left
        lbl.text = "Utilizar como forma de titulación"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    /* Text fields: nombre, apellido, perfil del alumno, */
    let nameField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 18)
        field.placeholder = "nameField"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let lastNameField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 18)
        field.placeholder = "LASTNAMEFIELD"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let profileField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 18)
        field.placeholder = "profile of student"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    let certificationSwch: UISwitch = {
        let swch = UISwitch()
        swch.thumbTintColor = .gray
        swch.onTintColor = .blue
        swch.translatesAutoresizingMaskIntoConstraints = false
        return swch
    }()
    private let sendBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Enviar", for: .normal)
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 20
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("init vista")
        setupLayout()
    }
    
    func setupLayout() {
        //        addSubview(avatar)
        //        NSLayoutConstraint.activate([
        //            avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        //            avatar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        //            avatar.widthAnchor.constraint(equalToConstant: 224),
        //            avatar.heightAnchor.constraint(equalToConstant: 224)
        //            ])
//        addSubview(navBar)
//        NSLayoutConstraint.activate([
//            navBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
//            navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
//            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
//            ])
        addSubview(nameLbl)
        NSLayoutConstraint.activate([
            nameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            nameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraintConstant.left),
            nameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraintConstant.right),
            nameLbl.heightAnchor.constraint(equalToConstant: componentHeight)
            
            ])
        addSubview(nameField)
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 5),
            nameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraintConstant.left),
            nameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraintConstant.right),
            nameField.heightAnchor.constraint(equalToConstant: componentHeight)
            ])
        
        addSubview(lastNameLbl)
        NSLayoutConstraint.activate([
            lastNameLbl.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 5),
            lastNameLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraintConstant.left),
            lastNameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraintConstant.right),
            lastNameLbl.heightAnchor.constraint(equalToConstant: componentHeight)
            
            ])
        addSubview(lastNameField)
        NSLayoutConstraint.activate([
            lastNameField.topAnchor.constraint(equalTo: lastNameLbl.bottomAnchor, constant: 5),
            lastNameField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraintConstant.left),
            lastNameField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraintConstant.right),
            lastNameField.heightAnchor.constraint(equalToConstant: componentHeight)
            ])
        addSubview(profileLbl)
        NSLayoutConstraint.activate([
            profileLbl.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 5),
            profileLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraintConstant.left),
            profileLbl.heightAnchor.constraint(equalToConstant: componentHeight)
            
            ])
        addSubview(profileField)
        NSLayoutConstraint.activate([
            profileField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: 5),
            profileField.leadingAnchor.constraint(equalTo: profileLbl.trailingAnchor, constant: constraintConstant.left-20),
            profileField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraintConstant.right),
            profileField.heightAnchor.constraint(equalToConstant: componentHeight),
            profileField.widthAnchor.constraint(equalToConstant: 190)
            
            ])
        addSubview(certificationLbl)
        NSLayoutConstraint.activate([
            certificationLbl.topAnchor.constraint(equalTo: profileLbl.bottomAnchor, constant: 5),
            certificationLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constraintConstant.left),
            certificationLbl.heightAnchor.constraint(equalToConstant: componentHeight)
            
            ])
        addSubview(certificationSwch)
        NSLayoutConstraint.activate([
            certificationSwch.topAnchor.constraint(equalTo: profileLbl.bottomAnchor, constant: 5),
            certificationSwch.leadingAnchor.constraint(equalTo: certificationLbl.trailingAnchor, constant: constraintConstant.left),
            certificationSwch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: constraintConstant.right),
            certificationSwch.heightAnchor.constraint(equalToConstant: componentHeight),
            ])
        
        addSubview(sendBtn)
        NSLayoutConstraint.activate([
            sendBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            sendBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            sendBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            sendBtn.heightAnchor.constraint(equalToConstant: 48)
            ])
    }
    
    @objc
    func handleTap() {
        self.endEditing(true)
    }

}
