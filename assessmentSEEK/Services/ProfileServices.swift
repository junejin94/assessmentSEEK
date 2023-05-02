//
//  ProfileServices.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import Foundation

actor ProfileServices: Network {
    static let shared = ProfileServices()

    private init() {}

    func changePassword(oldPassword: String, newPassword: String) -> Result<ChangePasswordModel, Error> {
        //Mock API call, assume successful
        return .success(ChangePasswordModel(success: true))
    }
}
