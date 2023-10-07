//
//  Item.swift
//  ChatGPTSwiftUI
//
//  Created by Pelin AY on 7.10.2023.
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
