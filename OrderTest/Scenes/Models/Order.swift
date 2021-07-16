//
//  ProductResponse.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import Foundation

struct Order: Codable, Identifiable {
    let id: Int
    let productDescription: String
    let price: Int
    let deliverTo: DeliverTo
    let imageURL: String
    let status: String

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
struct DeliverTo: Codable {
    let name, address: String
}


extension Order {
    static var dummyData: Order {
        .init(id: 20, productDescription: "Red Roses", price: 50, deliverTo: DeliverTo(name: "Bianca", address: "Strada Soarelui nr. 10"), imageURL: "https://images.pexels.com/photos/736230/pexels-photo-736230.jpeg", status: "new")
    }
}
