//
//  FireBaseAnalyticsEnging.swift
//  Leaf
//
//  Created by Mohamed Atallah on 01/10/2025.
//

import FirebaseAnalytics

class FireBaseAnalyticsEnging: AnalyticsEngine {
    func setAnalyticsEvent(named name: String, metadata: [String : Any]?) {
        
        Analytics.logEvent(name, parameters: metadata)
    }
}
