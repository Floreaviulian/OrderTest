//
//  ProductEndpoint.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import Foundation


protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

enum OrderEndpoint {
    case getOrders
}

extension OrderEndpoint: APIBuilder {
    
    var baseUrl: URL {
        switch self {
        case .getOrders:
            return URL(string: "https://run.mocky.io")!
        }
    }
    
    var path: String {
        return "/v3/983b27a8-9134-4566-82c2-e7c2257445fb"
    }
    
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(self.path))
    }
    
}
