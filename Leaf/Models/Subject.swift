//
//  Subject.swift
//  Leaf
//
//  Created by Mohamed Atallah on 14/09/2025.
//

import Foundation
struct Subject: Decodable {
    let name: String?
    let works: [Book]
    
    enum CodingKeys: String, CodingKey {
        case name, works
    }
}
