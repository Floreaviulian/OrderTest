//
//  ProductsViewModel.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import Foundation
import Combine

enum OrdersState {
    case loading
    case success(orders: [Order])
    case failed(error: Error)
}

class OrderListViewModel: ObservableObject {
    private let service: OrderNetworkService
    private var orders = [Order]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: OrdersState = .loading
    
    init(service: OrderNetworkService = OrderNetworkServiceImpl()) {
        self.service = service
    }
    
    func getProduct() {
        self.state = .loading
        let cancellable = service
            .request(from: .getOrders)
            .sink { res in
                switch res {
                case .finished:
                    self.state = .success(orders: self.orders)
                break
                case .failure(let error):
                    self.state = .failed(error: error)
                break
                }
            } receiveValue: { response in
                self.orders = response
            }
        self.cancellables.insert(cancellable)
    }
}
