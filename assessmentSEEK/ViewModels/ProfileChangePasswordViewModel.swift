//
//  ProfileChangePasswordViewModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import Foundation
import SwiftUI

actor ProfileChangePasswordViewModel: ObservableObject {
    @MainActor @Published private(set) var state: ViewState = .loaded

    @MainActor func togglePasswordImage(show: Bool) -> some View {
        return Image(systemName: show ? "eye.slash.fill" : "eye.fill").padding()
    }

    func changePassword(oldPassword: String, newPassword: String) async throws -> Bool {
        //Mock API, assume password change is successful, and require re-login
        if oldPassword.isEmpty || newPassword.isEmpty {
            throw ChangePasswordError.emptyNewOrOldPassword
        }

        await MainActor.run { state = .loading }

        try? await Task.sleep(for: .seconds(2))

        let result = await ProfileServices.shared.changePassword(oldPassword: oldPassword, newPassword: newPassword)

        await MainActor.run { state = .loaded }

        switch result {
        case .success(let success):
            return success.success
        case .failure(let failure):
            throw failure
        }
    }
}
