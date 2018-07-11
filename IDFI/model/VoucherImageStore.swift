//
//  VoucherImageStore.swift
//  IDFI
//
//  Created by IvánMS on 10/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit
class VoucherImageStore {
    
    let cache = NSCache<NSString,UIImage>()
    /* Funciones para guardar imagen en caché, recuperarla o borrarla */
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        /* Se crea URL para guardar la imágen */
        let url = imageURL(forKey: key)
        /* Se alamacenará una representación JPG de la imágen */
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            /* Escribe en la URL la imágen */
            try? data.write(to: url, options: [.atomic])
        }
    }
    func image(forKey key: String) -> UIImage? {
        /* Si la imágen existe en caché la recupera */
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        /* Si no existe en caché la trae del sistema de archivos s*/
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
    }
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)

        } catch let deleteError {
            print("Error borrando la imagen del disco: \(deleteError)")
        }
    }
    
    /* URL donde se guardarán las imágenes en el sandbox de la aplicación */
    func imageURL(forKey key: String) -> URL {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
}
