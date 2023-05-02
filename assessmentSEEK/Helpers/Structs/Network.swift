//
//  Network.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: Data? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "jobstreet.com"
    }
}

protocol Network {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension Network {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path

        if (endpoint.method == .get) {
            urlComponents.queryItems = endpoint.queryItems
        }

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)

            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }

            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }

                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

enum JobStreetEndpoint {
    case auth(username: String, password: String)
    case active(limit: Int, page: Int)
    case job(id: String!)
    case jobs(limit: Int, page: Int)
    case reset(email: String)
}

extension JobStreetEndpoint: Endpoint {
    var path: String {
        switch self {
        case .auth:
            return "/auth"
        case .active:
            return "/active"
        case .job:
            return "/job"
        case .jobs:
            return "/jobs"
        case .reset:
            return "/reset"
        }
    }

    var method: RequestMethod {
        switch self {
        case .auth, .reset:
            return .post
        case .active, .job, .jobs:
            return .get
        }
    }

    var header: [String: String]? {
        let accessToken = UserDefaults.standard.object(forKey: "jwt") ?? ""

        return ["Authorization": "Bearer \(accessToken)", "Content-Type": "application/json;charset=utf-8"]
    }

    var body: Data? {
        switch self {
        case .auth(let username, let password):
            return try? JSONSerialization.data(withJSONObject: ["username": username, "password": password])
        case .active:
            return nil
        case .job:
            return nil
        case .jobs:
            return nil
        case .reset(let email):
            return try? JSONSerialization.data(withJSONObject: ["email": email])
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .auth, .reset:
            return nil
        case .active(let limit, let page):
            return [URLQueryItem(name: "limit", value: String(limit)), URLQueryItem(name: "page", value: String(page))]
        case .job(let id):
            return [URLQueryItem(name: "id", value: id)]
        case .jobs(let limit, let page):
            return [URLQueryItem(name: "limit", value: String(limit)), URLQueryItem(name: "page", value: String(page))]
        }
    }
}
