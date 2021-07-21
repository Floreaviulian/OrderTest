//
//  OrderDetailsViewModel.swift
//  OrderTest
//
//  Created by Florea Iulian on 7/21/21.
//

import Combine
import SwiftUI

class OrderDetailsViewModel: ObservableObject {
    @Published private(set) var order: Order
    
    init(order: Order) {
        self.order = order
    }
    
    func saveStatus(_ status: OrderStatus) {
        order.currentStatus = status
        //force to republish
        order = order
    }
}
