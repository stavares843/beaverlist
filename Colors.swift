import SwiftUI

extension Color {
    init(hex: UInt, opacity: Double = 1) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255

        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: opacity
        )
    }

    static let neonBlue = Color(hex: 0xfc5c65)

    static let customGradient = LinearGradient(
            gradient: Gradient(colors: [Color(hex: 0x3a6186), Color(hex: 0x89253e)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    static let slateMist = LinearGradient(
            gradient: Gradient(colors: [Color(hex: 0x4ECDC4), Color(hex: 0x556270)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    
    static let honeyDew = LinearGradient(
            gradient: Gradient(colors: [Color(hex: 0x43C6AC), Color(hex: 0xF8FFAE)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    
    static let blueberryBlush = LinearGradient(
        gradient: Gradient(colors: [.blue, .purple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let mysticTwilight =  LinearGradient(
        gradient: Gradient(
        colors: [Color(hex: 0x3a6186), Color(hex: 0x89253e)]),
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let sunsetBlaze =  LinearGradient(
        gradient: Gradient(
        colors: [.red, .yellow]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

