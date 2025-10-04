//
//  AnalyticsManager.swift
//  Leaf
//
//  Created by Mohamed Atallah on 01/10/2025.
//

import Foundation

class AnalyticsManager {
    private var engine: AnalyticsEngine?
    static let shared = AnalyticsManager()
    
    private init() { }
    
    func configure(engine: AnalyticsEngine) {
        self.engine = engine
    }
    
    func track(eventName: String, metadata: [String: Any]?) {
        guard let engine else {
            Logger.shared.log("Analytics engine not provided", level: .error)
            return
        }
        engine.setAnalyticsEvent(named: eventName, metadata: metadata)
    }
}
