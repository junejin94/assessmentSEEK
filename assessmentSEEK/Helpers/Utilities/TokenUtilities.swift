//
//  TokenUtilities.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import Foundation

class TokenUtilities {
    static let shared = TokenUtilities()

    private init() {}

    func getWebToken(username: String, password: String) async throws -> JWT {
        let result = try await TokenServices.shared.fetchToken(username: username, password: password)

        try? await Task.sleep(for: .seconds(2))

        switch result {
        case .success(let success):
            return try processToken(token: success.token)
        case .failure(let failure):
            throw failure
        }
    }

    func changeName(newDisplay: String) async throws -> JWT {
        let result = await TokenServices.shared.changeName(newDisplayName: newDisplay)

        try? await Task.sleep(for: .seconds(2))

        switch result {
        case .success(let success):
            return try processToken(token: success.token)
        case .failure(let failure):
            throw failure
        }
    }

    private func processToken(token: String) throws -> JWT {
        let temp = JWT(raw: token)

        try temp.decode()

        UserDefaults.standard.set(token, forKey: "jwt")

        return temp
    }
}
