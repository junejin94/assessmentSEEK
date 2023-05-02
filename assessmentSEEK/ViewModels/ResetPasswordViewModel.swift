//
//  ResetPasswordViewModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation

actor ResetPasswordViewModel: ObservableObject {
    @MainActor @Published private(set) var state: ViewState = .loaded

    func sendEmail(username: String) async throws -> Bool {
        if username.isEmpty {
            throw ResetPasswordError.emptyEmail
        }

        if !username.isValidEmail {
            throw ResetPasswordError.invalidEmail
        }

        await MainActor.run { state = .loading }

        let result = try await ResetPasswordServices.shared.sendPasswordResetEmail(username: username)

        switch result {
        case .success(_):
            await MainActor.run { state = .loaded }

            return true
        case .failure(let failure):
            await MainActor.run { state = .loaded }

            throw failure
        }
    }
}
