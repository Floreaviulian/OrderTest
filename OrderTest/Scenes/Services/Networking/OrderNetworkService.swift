//
//  ProductsService.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import Foundation
import Combine

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong"
        case .unknown:
            return "This error is unknown"
        }
    }
}

protocol OrderNetworkService {
    func request(from endpoint: OrderEndpoint) -> AnyPublisher<[Order], APIError>
}

struct OrderNetworkServiceImpl: OrderNetworkService {
    func request(from endpoint: OrderEndpoint) -> AnyPublisher<[Order], APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<[Order], APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if (200...299).contains(response.statusCode) {
                    
                    return Just(data)
                        .decode(type: [Order].self, decoder: JSONDecoder())
                        .mapError { error in
                            APIError.decodingError

                        }
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
