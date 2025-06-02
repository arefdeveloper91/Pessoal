//
//  Extensions.swift
//  apresentacaoTela
//
//  Created by Aref Chucri on 02/06/25.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// Extensão para ButtonStyle personalizado
extension ButtonStyle where Self == AlloyPrimaryButtonStyle {
    static func alloyPrimary(
        sizing: AlloyPrimaryButtonStyle.Sizing = .default,
        shadowSize: AlloyPrimaryButtonStyle.ShadowSize = .regular,
        glow: Bool = false
    ) -> AlloyPrimaryButtonStyle {
        AlloyPrimaryButtonStyle(sizing: sizing, shadowSize: shadowSize, glow: glow)
    }
}

// Enum para temas
enum AppTheme: String, CaseIterable {
    case light = "Claro"
    case dark = "Escuro"
    case system = "Sistema"
}

// ButtonStyle personalizado
struct AlloyPrimaryButtonStyle: ButtonStyle {
    enum Sizing {
        case small
        case `default`
        case large
        
        var height: CGFloat {
            switch self {
            case .small: return 36
            case .default: return 50
            case .large: return 60
            }
        }
        
        var fontSize: CGFloat {
            switch self {
            case .small: return 14
            case .default: return 16
            case .large: return 18
            }
        }
    }
    
    enum ShadowSize {
        case none
        case small
        case regular
        case large
        
        var radius: CGFloat {
            switch self {
            case .none: return 0
            case .small: return 4
            case .regular: return 8
            case .large: return 16
            }
        }
        
        var y: CGFloat {
            switch self {
            case .none: return 0
            case .small: return 2
            case .regular: return 4
            case .large: return 8
            }
        }
    }
    
    var sizing: Sizing = .default
    var shadowSize: ShadowSize = .regular
    var glow: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: sizing.fontSize, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: sizing.height)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.blue)
                    
                    if glow {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue)
                            .blur(radius: 8)
                            .opacity(0.7)
                    }
                }
            )
            .shadow(
                color: glow ? Color.blue.opacity(0.5) : Color.black.opacity(0.15),
                radius: shadowSize.radius,
                x: 0,
                y: shadowSize.y
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

