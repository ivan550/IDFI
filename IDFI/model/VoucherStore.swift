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
}
