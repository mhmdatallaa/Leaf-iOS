//
//  AnalyticsEngine.swift
//  Leaf
//
//  Created by Mohamed Atallah on 01/10/2025.
//

import Foundation

protocol AnalyticsEngine {
    func setAnalyticsEvent(named name: String, metadata: [String : Any]?) 
}
