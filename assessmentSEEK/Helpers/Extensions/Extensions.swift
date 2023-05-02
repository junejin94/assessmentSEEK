//
//  Extensions.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import SwiftUI
import Foundation

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }

    var containsNumbersOrSpecial: Bool {
        let numbersRange = self.rangeOfCharacter(from: .decimalDigits)
        let specialsRange = self.rangeOfCharacter(from: CharacterSet(charactersIn: "[$&+,:;=?@#|'<>.^*()%!-]"))

        return numbersRange != nil || specialsRange != nil
    }
}

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
