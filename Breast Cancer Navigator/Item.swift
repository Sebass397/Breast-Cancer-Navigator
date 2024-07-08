//
//  Item.swift
//  Breast Cancer Navigator
//
//  Created by Carlos Alemany on 7/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
