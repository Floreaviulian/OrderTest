//
//  ProductResponse.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import Foundation

enum OrderStatus: String, CaseIterable {
    case new = "new"
    case pending = "peding"
    case delivered = "delivered"
}

struct Order: Codable, Identifiable {
    let id: Int
    let productDescription: String
    let price: Int
    let deliverTo: Client
    let imageURL: String
   private let status: String
    
    var currentStatus: OrderStatus {
        OrderStatus(rawValue: status) ?? .new
    }

    enum CodingKeys: String, CodingKey {
        case id
        case productDescription = "description"
        case price
        case deliverTo = "deliver_to"
        case imageURL = "image_url"
        case status
    }
}

// MARK: - DeliverTo
struct Client: Codable {
    let name, address: String
}


extension Order {
    static var dummyData: Order {
        .init(id: 20, productDescription: "Red Roses", price: 50, deliverTo: Client(name: "Bianca", address: "Strada Soarelui nr. 10"), imageURL: "https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg", status: "new")
    }
}
