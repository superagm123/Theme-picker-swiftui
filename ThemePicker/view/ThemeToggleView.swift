//
//  ThemeToggleView.swift
//  ThemePicker
//
//  Created by Alfonso Gonzalez Miramontes on 09/07/25.
//

import SwiftUI

struct ThemeToggleView: View {
    @AppStorage("AppTheme") private var appTheme: AppTheme = .system
    
    @State private var dragOffset: CGFloat = .zero
    @State private var lastOffset: CGFloat = .zero
    
    private let totalWidth: CGFloat = 150
    private let capsuleHeight: CGFloat = 50
    
    var segmentedWidth: CGFloat { totalWidth / 3 }
    
    private var progress: CGFloat {
        dragOffset / segmentedWidth
    }
    
    private var dynamicColor: Color {
        if progress > 0 {
            return .yellow.opacity(abs(progress))
        } else {
            return .cyan.opacity(abs(progress))
        }
    }
    
    private var dynamicWidth: CGFloat {
        let absoluteProgress = abs(progress)
        return totalWidth * absoluteProgress
    }
    
    var toggleImage: some View {
        Image(systemName: appTheme.icon)
            .imageScale(.large)
            .foregroundStyle(appTheme.iconColor)
            .padding(10)
            .background(.white, in: .circle)
            .shadow(color: .gray, radius: 1, x: -1, y: 1)
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.thinMaterial)
                .frame(width: totalWidth, height: capsuleHeight)
            
            Capsule()
                .fill(dynamicColor)
                .frame(width: dynamicWidth, height: capsuleHeight)
                .offset(x: progress > 0 ?
                        -totalWidth/2 + dynamicWidth/2 :
                        totalWidth/2 - dynamicWidth/2)
            
            toggleImage
                .offset(x: dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let translation = value.translation.width
                            let newOffset = lastOffset + translation
                            
                            if newOffset >= -segmentedWidth && newOffset <= segmentedWidth {
                                dragOffset = newOffset
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                let newOffset = lastOffset + value.translation.width
                                
                                if newOffset <= -segmentedWidth / 2 {
                                    appTheme = .dark
                                } else if newOffset >= segmentedWidth / 2 {
                                    appTheme = .light
                                } else {
                                    appTheme = .system
                                }
                                
                                lastOffset = offsetForTheme(appTheme, segmentedWidth: segmentedWidth)
                                dragOffset = lastOffset
                            }
                        }
                )
        }
    }
    
    private func offsetForTheme(_ theme: AppTheme, segmentedWidth: CGFloat) -> CGFloat {
        switch theme {
        case .light: return segmentedWidth
        case .dark: return -segmentedWidth
        case .system: return 0
        }
    }
}

#Preview {
    ThemePickerView{
        ThemeToggleView()
    }
}
