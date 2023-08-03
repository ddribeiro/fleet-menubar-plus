//
//  NetworkManager.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 8/3/23.
//

import Foundation
import SwiftUI

struct AppEnvironment {
    var name: String?
    var baseURL: URL
    var session: URLSession

    static let production = AppEnvironment(
        name: "Production",
        baseURL: URL(string: "https://harmonize.cloud.fleetdm.com/api/v1/fleet/")!,
        session: {
            let configuration = URLSessionConfiguration.default
            if let apiKey = Bundle.main.infoDictionary?["PROD_API_KEY"] as? String {
                configuration.httpAdditionalHeaders = [
                    "Authorization": "Bearer \(apiKey)"
                ]
            }
            return URLSession(configuration: configuration)
        }()
    )

#if DEBUG
    static let staging = AppEnvironment(
        name: "Staging",
        baseURL: URL(string: "https://harmonize-stg.cloud.fleetdm.com/api/v1/fleet/")!,
        session: {
            let configuration = URLSessionConfiguration.default
            if let apiKey = Bundle.main.infoDictionary?["STG_API_KEY"] as? String {
                configuration.httpAdditionalHeaders = [
                    "Authorization": "Bearer \(apiKey)"
                ]
            }
            return URLSession(configuration: configuration)
        }()
    )
#endif
}

enum HTTPMethod: String {
    case delete, get, patch, post, put

    var rawValue: String {
        String(describing: self).uppercased()
    }
}

struct NetworkManagerKey: EnvironmentKey {
    static var defaultValue = NetworkManager(environment: .staging)
}

extension EnvironmentValues {
    var networkManager: NetworkManager {
        get { self[NetworkManagerKey.self] }
        set { self[NetworkManagerKey.self] = newValue }
    }
}

struct NetworkManager {
    var environment: AppEnvironment

    func fetch<T>(_ resource: Endpoint<T>, with data: Data? = nil) async throws -> T {
        guard let url = URL(string: resource.path, relativeTo: environment.baseURL) else {
            throw URLError(.unsupportedURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.httpBody = data
        request.allHTTPHeaderFields = resource.headers

        var (data, _) = try await environment.session.data(for: request)

        if let keyPath = resource.keyPath {
            if let rootObject = try JSONSerialization.jsonObject(with: data) as? NSDictionary {
                if let nestedObject = rootObject.value(forKeyPath: keyPath) {
                    data = try JSONSerialization.data(withJSONObject: nestedObject, options: .fragmentsAllowed)
                }
            }
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }

    // swiftlint:disable:next line_length
    func fetch<T>(_ resource: Endpoint<T>, with data: Data? = nil, attempts: Int, retryDelay: Double = 1) async throws -> T {
        do {
            print("Attempting to fetch (Attempts remaining: \(attempts)")
            return try await fetch(resource, with: data)
        } catch {
            if attempts > 1 {
                try await Task.sleep(for: .milliseconds(Int(retryDelay * 1000)))
                return try await fetch(resource, with: data, attempts: attempts - 1, retryDelay: retryDelay)
            } else {
                throw error
            }
        }
    }

    func fetch<T>(_ resource: Endpoint<T>, with data: Data? = nil, defaultValue: T) async throws -> T {
        do {
            return try await fetch(resource, with: data)
        } catch {
            return defaultValue
        }
    }
}
