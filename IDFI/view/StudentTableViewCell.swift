//
//  StudentTableViewCell.swift
//  IDFI
//
//  Created by IvánMS on 12/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func updateStudent(_ student: Student) {
        nameLbl.text = student.name
    }

}
