//
//  TabBarViewModel.swift
//  ThmaneyahAssessment
//
//  Created by Maram Alghanoom on 26/07/2025.
//

import Foundation

class TabBarViewModel: ObservableObject {
    @Published var selectedTabId: Int = 2
    @Published var tabs: [TabItem] = []
    
    private let tabService: TabServiceProtocol
    
    init(tabService: TabServiceProtocol = TabServiceImplementation()) {
        self.tabService = tabService
        loadTabs()
    }
    
    func selectTab(_ tabId: Int) {
        selectedTabId = tabId
        tabService.selectTab(tabId)
    }
    
    func isTabSelected(_ tabId: Int) -> Bool {
        return selectedTabId == tabId
    }
    
    private func loadTabs() {
        tabs = tabService.getTabs()
    }
}
