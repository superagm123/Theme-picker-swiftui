//
//  ThemeSwitcherView.swift
//  ThemePicker
//
//  Created by Alfonso Gonzalez Miramontes on 09/07/25.
//


import SwiftUI

struct ThemePickerView<Content: View>: View {
    @ViewBuilder var content: Content
    @AppStorage("AppTheme") private var appTheme: AppTheme = .system
    
    var body: some View {
        content
            .preferredColorScheme(appTheme.colorScheme)
    }
}
