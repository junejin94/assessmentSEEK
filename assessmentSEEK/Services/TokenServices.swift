//
//  TokenServices.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import Foundation

actor TokenServices: Network {
    static let shared = TokenServices()

    private init() {}

    func fetchToken(username: String, password: String) async throws -> Result<Token, Error> {
//        let result = await sendRequest(endpoint: JobStreetEndpoint.auth(username: username, password: password), responseModel: Token.self)
//
//        switch result {
//        case .success(let success):
//            return .success(success)
//        case .failure(let failure):
//            return .failure(failure)
//        }

        // Mock API call, assumes the call was successful and retrieve JWT
        let mockToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2ODI3NjM5NTIsImV4cCI6MTcxNDMxNDM1MiwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsInVzZXJJZCI6IjEiLCJkaXNwbGF5IjoiSm9obiJ9.zonLumdCeRKjWkSznmpmYPzliNaH4qkmcjsBnApgg18"

        return .success(Token(token: mockToken))
    }

    func changeName(newDisplayName: String) -> Result<Token, Error> {
        // Mock API call, assumes the name changed to "Jane" successfully
        let mockToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2ODI3NjM5NTIsImV4cCI6MTcxNDMxNDM1MiwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsInVzZXJJZCI6IjEiLCJkaXNwbGF5IjoiSmFuZSJ9.nf48Rsf9LXFDJUpNd0DfNXC4wscBFH6lAVJhm3kH2M8"

        return .success(Token(token: mockToken))
    }
}
