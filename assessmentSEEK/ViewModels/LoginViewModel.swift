//
//  LoginViewModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import SwiftUI
import Foundation

actor LoginViewModel: ObservableObject {
    @MainActor @Published private(set) var state: ViewState = .loaded

    @MainActor func togglePasswordImage(show: Bool) -> some View {
        return Image(systemName: show ? "eye.slash.fill" : "eye.fill").padding()
    }

    func login(username: String, password: String) async throws -> Bool {
        do {
            if username.isEmpty || password.isEmpty {
                throw LoginError.emptyEmailOrPassword
            }

            if !username.isValidEmail {
                throw LoginError.invalidEmail
            }

            await MainActor.run { state = .loading }

            _ = try await TokenUtilities.shared.getWebToken(username: username, password: password)

            await MainActor.run { state = .loaded }

            return true
        } catch let error {
            await MainActor.run { state = .loaded }

            throw error
        }
    }
}
