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
    var generationStudents = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        DatabaseService.shared.studentRef.observeSingleEvent(of: .value) { (snapshot) in
            var temporal = [Student]()
            for student in snapshot.children.allObjects as! [DataSnapshot]{
                /* Si el identificador del studiante se encuentra en el array de estudiantes de la generación se guardan los datos, de otra manera se verifica el siguiente uuid */
                let uuid = student.key
                guard self.generationStudents.contains(uuid) else {
                    continue
                }
                if let data = student.value as? [String:AnyObject],
                    let certificateId = data["certId"] as? String,
                    let profile = data["profile"] as? [String:AnyObject],
                let name = profile["name"] as? String,
                let lastName = profile["lastName"] as? String,
                let profileAcademic = profile["profileAcademic"] as? Bool,
                let language = profile["language"] as? Bool,
                let socialService = profile["socialService"] as? Bool{
                    
                    temporal.append(Student(name: name, lastName: lastName, language: language, socialService: socialService, profileAcadem: profileAcademic, certificateId: certificateId))
                }
                
            }
            self.students = temporal
            self.tableView?.reloadData()
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
