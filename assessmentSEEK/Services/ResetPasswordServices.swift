//
//  ResetPasswordServices.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import Foundation

actor ResetPasswordServices: Network {
    static let shared = ResetPasswordServices()

    private init() {}

    func sendPasswordResetEmail(username: String) async throws -> Result<Bool, Error> {
        // Mock API call, send reset password email, assume successful
//        let result = await sendRequest(endpoint: JobStreetEndpoint.reset(email: username), responseModel: ResetPasswordCodable.self)
//
//        switch result {
//        case .success(let success):
//            return .success(success.success)
//        case .failure(let failure):
//            throw failure
//        }
        try? await Task.sleep(for: .seconds(2))

        return .success(true)
    }
}
