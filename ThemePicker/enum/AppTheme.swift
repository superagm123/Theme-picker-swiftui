//
//  AppTheme.swift
//  ThemePicker
//
//  Created by Alfonso Gonzalez Miramontes on 09/07/25.
//

import SwiftUI

enum AppTheme: String {
    case light, dark, system
    
    var colorScheme: ColorScheme? {
        switch self {
        case .light: .light
        case .dark: .dark
        case .system: nil
        }
    }
    
    var icon: String {
        switch self {
        case .light: "sun.max.fill"
        case .dark: "moon.stars.fill"
        case .system: "arrow.trianglehead.2.clockwise"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .light: .yellow
        case .dark: .cyan
        case .system: .secondary
        }
    }
}
