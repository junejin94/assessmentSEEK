//
//  JWT.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import Foundation

class JWT {
    var raw: String

    private(set) var signed: Data? = Data()
    private(set) var signature: String? = ""
    private(set) var claims: ClaimsModel = ClaimsModel()

    init(raw: String) {
        self.raw = raw
    }

    func decode() throws {
        let parts = self.raw.components(separatedBy: ".")

        if parts.count != 3 { throw JWTError.invalidJWT }

        self.signed = (parts[0] + "." + parts[1]).data(using: .ascii) ?? Data()
        self.signature = parts[2]

        do {
            let payload = try decodeJWTPart(part: parts[1])

            guard let userId = payload["userId"] as? String else { throw JWTError.missingData }
            guard let display = payload["display"] as? String else { throw JWTError.missingData }
            guard let exp = payload["exp"] as? Double else { throw JWTError.missingData }

            self.claims = ClaimsModel(userId: userId, display: display, exp: Date(timeIntervalSince1970: Double(exp)))
        } catch let error {
            throw error
        }
    }

    func hasExpired() -> Bool {
        return Date() > self.claims.exp
    }

    private func base64StringWithPadding(encodedString: String) -> String {
        var stringTobeEncoded = encodedString.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/")

        let paddingCount = encodedString.count % 4

        for _ in 0..<paddingCount {
            stringTobeEncoded += "="
        }

        return stringTobeEncoded
    }

    private func decodeJWTPart(part: String) throws -> [String: Any] {
        let payloadPaddingString = base64StringWithPadding(encodedString: part)

        guard let payloadData = Data(base64Encoded: payloadPaddingString) else {
            throw JWTError.unableToConvert
        }

        guard let decoded = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any] else {
            throw JWTError.unableToConvert
        }

        return decoded
    }
}
