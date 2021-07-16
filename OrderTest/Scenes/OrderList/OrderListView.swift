//
//  ProductsView.swift
//  Drawing
//
//  Created by Iulian FLorea on 7/16/21.
//

import SwiftUI
import URLImage

struct OrderListView: View {
    @ObservedObject var viewModel: OrderListViewModel = OrderListViewModel()
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed:
                    VStack {
                        Text("There was an issue fetching your orders. Please try again.")
                            .multilineTextAlignment(.center)
                            .padding()
                            .font(.title2)
                        Button {
                            viewModel.getProduct()
                        } label: {
                            Text("Retry")
                                .padding([.leading, .trailing], 50)
                                .padding([.top, .bottom], 15)
                                .foregroundColor(.white)
                        }
                        .background(Color.blue)
                        .cornerRadius(8.0)
                    }
                case .success(let orders):
                    List(orders, id: \.id) { order in
                        NavigationLink(destination: OrderDetailsView(order: order)) {
                            OrderCell(order: order)
                        }
                    }
                }
            }.navigationTitle(Text("Orders"))
        }
        .onAppear(perform: {
            viewModel.getProduct()
        })
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
    }
}
