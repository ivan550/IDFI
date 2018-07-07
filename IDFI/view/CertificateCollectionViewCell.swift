//
//  CertificateCollectionViewCell.swift
//  IDFI
//
//  Created by IvánMS on 05/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
import FirebaseStorage

class CertificateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var certificateImage: UIImageView!
    @IBOutlet weak var placesLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    func styleImage() {
        certificateImage.image = UIImage(named: "load")
        certificateImage.translatesAutoresizingMaskIntoConstraints = false
        certificateImage.layer.cornerRadius = 20
        certificateImage.layer.masksToBounds = true
    }
    func updateImage(imageURL: String) {
        let httpRef = Storage.storage().reference(forURL: imageURL)
        httpRef.getData(maxSize: 8*1024*1024, completion: { (data, error) in
            if error != nil{
                print("(error)")
                return
            }else{
                DispatchQueue.main.async(execute: {
                    self.certificateImage?.image = UIImage(data: data!)
                })
            }
            
        })
    }
    func updateCertificate(certificate: Certificate) {
        self.placesLbl.text = "Lugares Disponibles: "+String(certificate.places)
        self.nameLbl.text = certificate.name
        self.styleImage()
        self.updateImage(imageURL: certificate.imageURL)
        
    }
}
