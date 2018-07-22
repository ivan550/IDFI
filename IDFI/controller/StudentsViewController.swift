//
//  StudentsViewController.swift
//  IDFI
//
//  Created by IvánMS on 12/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "studentCell"
class StudentsViewController: UITableViewController {

    @IBOutlet weak var certificateNameLbl: UILabel!
    @IBOutlet weak var generationNameLbl: UILabel!
    var students = [Student]()
    var selectedCert: Certificate!
    var selectedGene: Generation!


    override func viewDidLoad() {
        super.viewDidLoad()
            
        DatabaseService.shared.studentRef.observeSingleEvent(of: .value) { (snapshot) in
            var temporal = [Student]()
            for student in snapshot.children.allObjects as! [DataSnapshot]{
                /* Si el identificador del studiante se encuentra en el array de estudiantes de la generación se guardan los datos, de otra manera se verifica el siguiente uuid */
                let uuid = student.key
                guard self.selectedGene.studentsId.contains(uuid) else {
                    continue
                }
                if let data = student.value as? [String:AnyObject],
                    let certificateId = data["certId"] as? String,
                    let profile = data["profile"] as? [String:AnyObject],
                let name = profile["name"] as? String,
                let lastName = profile["lastName"] as? String,
                let profileAcademic = profile["profileAcademic"] as? String,
                let language = profile["language"] as? Bool,
                let socialService = profile["socialService"] as? Bool,
                let degreeOption = profile["degreeOption"] as? Bool{
                    
                    temporal.append(Student(name: name, lastName: lastName, language: language, socialService: socialService, profileAcadem: profileAcademic, certificateId: certificateId,id: uuid, degreeOption: degreeOption))
                }
                
            }
            self.students = temporal
            self.tableView?.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        certificateNameLbl.text = selectedCert.name
        generationNameLbl.text = "Alumnos - \(selectedGene.name)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StudentTableViewCell
        let student = students[indexPath.row]
        cell.updateStudent(student)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* Tomamos el estudiante selccionado al controlador que mostrará sus detalles */
        let student = students[indexPath.row]
        /* Se mandan datos al navigation bar que controlará cuando se agregén comprobantes y se presenta */
        let tabBar = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
        let nav = tabBar.viewControllers![0] as! UINavigationController
        let st = nav.topViewController as! StudentVouchersViewController
        st.selectedStudent = student
        st.selectedCert = selectedCert
        let profile = tabBar.viewControllers![1] as! ProfileViewController
        profile.selectedStudent = student
        present(tabBar, animated: true, completion: nil)
    }

}
