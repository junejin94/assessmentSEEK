//
//  Errors.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import Foundation

enum JWTError: LocalizedError {
    case invalidJWT
    case expiredJWT
    case noLocalJWT
    case missingData
    case unableToConvert

    var errorDescription: String? {
        switch self {
        case .invalidJWT: return "The JWT is invalid"
        case .expiredJWT: return "The JWT is expired"
        case .noLocalJWT: return "There's no local JWT"
        case .missingData: return "The JWT is missing data"
        case .unableToConvert: return "Failed to convert to data"
        }
    }
}

enum LoginError: LocalizedError {
    case emptyEmailOrPassword
    case invalidEmail

    var errorDescription: String? {
        switch self {
        case .emptyEmailOrPassword: return "Either the email or password is empty"
        case .invalidEmail: return "Invalid email"
        }
    }
}

enum ResetPasswordError: LocalizedError {
    case emptyEmail
    case invalidEmail

    var errorDescription: String? {
        switch self {
        case .emptyEmail: return "The email is empty"
        case .invalidEmail: return "Invalid email"
        }
    }
}

enum RequestError: LocalizedError {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String? {
        switch self {
        case .decode: return "Decode error"
        case .unauthorized: return "Session expired"
        default: return "Unknown error"
        }
    }
}

enum ChangeNameError: LocalizedError {
    case emptyName
    case containsNumbersOrSpecialCharacters

    var errorDescription: String? {
        switch self {
        case .emptyName: return "The name is empty"
        case .containsNumbersOrSpecialCharacters: return "The name cannot contains numbers or special characters"
        }
    }
}

enum ChangePasswordError: LocalizedError {
    case emptyNewOrOldPassword

    var errorDescription: String? {
        switch self {
        case .emptyNewOrOldPassword: return "Please enter both old and new password"
        }
    }
}
