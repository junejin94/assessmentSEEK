//
//  JobServices.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation

actor JobServices: Network {
    static let shared = JobServices()

    private init() {}

    func sendPasswordResetEmail(username: String) async throws -> Result<Bool, Error> {
        // Mock API call, assume successful
//        let result = await sendRequest(endpoint: JobStreetEndpoint.reset(email: username), responseModel: ResetPassword.self)
//
//        switch result {
//        case .success(let success):
//            return .success(success.success)
//        case .failure(let failure):
//            return .failure(failure)
//        }

        return .success(true)
    }
}
