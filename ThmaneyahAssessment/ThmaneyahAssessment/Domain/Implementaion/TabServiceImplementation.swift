//
//  TabServiceImplementation.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Foundation

class TabServiceImplementation: TabServiceProtocol {
    func getTabs() -> [TabItem] {
        return [
            TabItem(id: 0, title: "المكتبة"),
            TabItem(id: 1, title: "المقالات الصوتية"),
            TabItem(id: 2, title: "البودكاست"),
            TabItem(id: 3, title: "لك")
        ]
    }
    
    func selectTab(_ tabId: Int) {
        print("Selected tab: \(tabId)")
    }
}
