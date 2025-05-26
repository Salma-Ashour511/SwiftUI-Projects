//
//  WishModel.swift
//  WishList
//
//  Created by V17SAshour1 on 26/05/2025.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
