//
//  ProfileViewController.swift
//  IDFI
//
//  Created by IvánMS on 21/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var degreeOptionSwch: UISwitch!
    @IBOutlet weak var socialServiceSwch: UISwitch!
    @IBOutlet weak var languageSwch: UISwitch!
    
    
    @IBOutlet weak var moneyPaidLbl: UILabel!
    @IBOutlet weak var moneyOwed: UILabel!
    
    var selectedStudent: Student!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLbl.text = selectedStudent.name + " " + selectedStudent.lastName
        profileLbl.text = String(selectedStudent.profileAcadem)
        degreeOptionSwch.isOn = selectedStudent.degreeOption
        socialServiceSwch.isOn = selectedStudent.socialService
        languageSwch.isOn = selectedStudent.language
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
