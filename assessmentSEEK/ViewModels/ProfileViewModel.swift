//
//  ProfileViewModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 01/05/2023.
//

import SwiftUI
import Foundation

class ProfileViewModel: ObservableObject {
    @AppStorage("jwt", store: .standard) var token: String = ""

    @Published private(set) var state: ViewState = .loaded

    private var tokenObj: JWT?

    var name: String {
        if let tokenObj, !token.isEmpty {
            do {
                try tokenObj.decode()
            } catch {
                return ""
            }

            return tokenObj.claims.display
        } else if !token.isEmpty {
            tokenObj = JWT(raw: token)

            do {
                try tokenObj?.decode()
            } catch {
                return ""
            }

            return tokenObj?.claims.display ?? ""
        } else {
            return ""
        }
    }

    @MainActor func changeName(newName: String) async throws -> Bool {
        if newName.isEmpty {
            throw ChangeNameError.emptyName
        }

        if newName.containsNumbersOrSpecial {
            throw ChangeNameError.containsNumbersOrSpecialCharacters
        }

        state = .loading

        let token = try await TokenUtilities.shared.changeName(newDisplay: newName)

        tokenObj = token

        state = .loaded

        return true
    }
}
