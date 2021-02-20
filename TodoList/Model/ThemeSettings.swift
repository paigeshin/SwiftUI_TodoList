//
//  ThemeSettings.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/21.
//

import SwiftUI

// MARK: - THEME CLASS

class ThemeSettings: ObservableObject {
    //get & set
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
