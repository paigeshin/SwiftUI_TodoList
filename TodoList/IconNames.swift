//
//  IconNames.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/21.
//

import Foundation
import SwiftUI

// MARK: - ALTERNATE ICONS
class IconNames: ObservableObject {
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    //decode info.plist files for getting `alternate` icon names
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for(_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String, Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                iconNames.append(icon)
            }
        }
    }
    
}

