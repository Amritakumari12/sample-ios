//
//  OMGShopManager.swift
//  OMGShop
//
//  Created by Mederic Petit on 20/10/2560 BE.
//  Copyright © 2560 Mederic Petit. All rights reserved.
//

class OMGShopManager {

    static let shared: OMGShopManager = OMGShopManager()

    init() {
        Theme.apply()
    }

}
