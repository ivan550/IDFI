//
//  GenerationsViewController.swift
//  IDFI
//
//  Created by IvánMS on 12/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "generationCell"
class GenerationsViewController: UITableViewController {
    
    @IBOutlet weak var certificateNameLbl: UILabel!
    var generations = [Generation]()
    var generationStudents = [String]()
    var selectedCert: Certificate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseService.shared.generationRef.observeSingleEvent(of: .value) { (snapshot) in
            /* Se crea un arreglo temporal que guardará los objetos de tipo generación */
            var temporal = [Generation]()
            for generation in snapshot.children.allObjects as! [DataSnapshot]{
                /* Sí el identificador del diplomado es diferente en la generación no toma la generación */
                if let data = generation.value as? [String: AnyObject],
                    let certId = data["certId"] as? String, certId != self.selectedCert.id{
                    continue
                }
                if let data = generation.value as? [String: AnyObject],
                    let name = data["name"] as? String,
                let students = data["students"] as? [String:AnyObject]{
                    let uui = generation.key
                    /* Se obtiene la lista de estudiantes y se le pasa al objeto como array */
                    let listStudents = Array(students.keys)
                    temporal.append(Generation(name: name, id: uui,studentsId: listStudents))
                }
            }
            /* Se reasigna el arreglo temporal a la variable de la clase que se presentará en el table view*/
            self.generations = temporal
            self.tableView?.reloadData()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        certificateNameLbl.text = selectedCert.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return generations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Se asigna la celda de tipo personalizada */
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! GenerationTableViewCell
        let generation = self.generations[indexPath.row]
        /* Pone en la vista cada etiqueta con su respectivo valor que contiene el objeto generación */
        cell.updateGeneration(generation)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /* Sí el segue disparado es editVoucher */
        switch segue.identifier {
        case "listStudents"?:
            /* Checamos que fila se seleccionó */
            if let row = tableView.indexPathForSelectedRow?.row {
                /* Tomamos el voucher selccionado y se lo pasamos al controlador que llenará los datos del comprobante */
                let generation = generations[row]
                let studentsViewController = segue.destination as! StudentsViewController
                studentsViewController.selectedGene = generation
                studentsViewController.selectedCert = selectedCert
            }
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    
}
