//
//  VoucherStore.swift
//  IDFI
//
//  Created by IvánMS on 09/07/18.
//  Copyright © 2018 ivanSo3. All rights reserved.
//

import UIKit

class VoucherStore {
    var allIVouchers = [Voucher]()
    /* Obtiene la URL apropiada del sistema de archivos donde se guardarán los comprobantes */
    let voucherArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("voucher.archive")
    }()
    @discardableResult func createVoucher() -> Voucher {
        let newVoucher = Voucher(random: true)
        allIVouchers.append(newVoucher)
        return newVoucher
    }
    func removeVoucher(_ voucher: Voucher) {
        if let index = allIVouchers.index(of: voucher) {
            allIVouchers.remove(at: index)
        }
    }
    func removeAll(){
        allIVouchers.removeAll()
    }
    func moveVoucher(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        /* Se guarda la referencia del objeto que se va mover para poder volver a insertarlo */
        let movedVoucher = allIVouchers[fromIndex]
        /* Se elimina el elemento y se inserta en la nueva posición */
        allIVouchers.remove(at: fromIndex)
        allIVouchers.insert(movedVoucher, at: toIndex)
    }
    /* Guardarán los comprobantes y el mètodo será llamado cuando la aplicación se mande a background */
    func saveChanges() -> Bool {
//        print("Guardando comprobantes en: \(voucherArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allIVouchers, toFile: voucherArchiveURL.path)
    }
    /* Carga los comprobantes que se hayan guardado cuando se mandó a background */
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: voucherArchiveURL.path) as? [Voucher] {
            allIVouchers = archivedItems
        }
    }
}
