//
//  TabServiceProtocol.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Foundation

protocol TabServiceProtocol {
    func getTabs() -> [TabItem]
    func selectTab(_ tabId: Int)
}
