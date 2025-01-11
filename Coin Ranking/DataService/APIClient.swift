//
//  APIClient.swift
//  Coin Ranking
//
//  Created by Sylvan Ash on 11/01/2025.
//

import Foundation

protocol APIEndpoint {
    var path: String { get }
    var parameters: [String: Any]? { get }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

protocol APIClient {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async -> Result<T, Error>
}

final class URLSessionAPIClient: APIClient {
    private let baseURL = "https://api.coinranking.com/v2"

    private static var apiKey: String {
        guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("Missing API Key!")
        }
        return key
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint) async -> Result<T, Error> {
        guard var url = URL(string: baseURL) else {
            return .failure(APIError.invalidURL)
        }
        url = url.appending(path: endpoint.path)

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return .failure(APIError.invalidURL)
        }
        components.queryItems = getQueryItems(for: endpoint.parameters)

        guard let url = components.url else {
            return .failure(APIError.invalidURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(Self.apiKey, forHTTPHeaderField: "x-access-token")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(APIError.invalidResponse)
            }

            // check HTTP status code
            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(APIError.invalidResponse)
            }

            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
        } catch _ as DecodingError {
            return .failure(APIError.invalidData)
        } catch {
            return .failure(APIError.invalidResponse)
        }
    }

    private func getQueryItems(for parameters: [String: Any]?) -> [URLQueryItem]? {
        let parameters = parameters ?? [:]

        return parameters.map { key, value in
            var stringValue: String?

            switch value {
            case let string as String:
                stringValue = string
            case let number as NSNumber:
                stringValue = number.stringValue
            case let array as [Any]:
                // Convert array to comma-separated string
                stringValue = array.map { "\($0)" }.joined(separator: ",")
            case let bool as Bool:
                stringValue = bool ? "true" : "false"
            default:
                // Skip unsupported types
                break
            }

            return URLQueryItem(name: key, value: stringValue)
        }
    }
}
