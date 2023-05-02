//
//  ViewModifier.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation
import SwiftUI

struct TopDownSpacer: ViewModifier {
    func body(content: Content) -> some View {
        Spacer()
        content
        Spacer()
    }
}

struct CellPadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .padding(.bottom, 8)
    }
}
