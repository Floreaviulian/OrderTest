//
//  OrderDetailsView.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import SwiftUI
import URLImage

struct OrderDetailsView: View {
    var statusTypes = OrderStatus.allCases
    @ObservedObject private var viewModel: OrderDetailsViewModel
    @State private var currStatus: OrderStatus
    var body: some View {
        ScrollView {
            VStack {
                if let url = URL(string: viewModel.order.imageURL) {
                    URLImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                            .padding(20)
                    }
                }
                Text("Price: \(viewModel.order.price)$").padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(viewModel.order.deliverTo.name)")
                    Divider()
                    Text("Address: \(viewModel.order.deliverTo.address)")
                    Divider()
                    Text("Current status: \(viewModel.order.currentStatus.rawValue)")
                    Divider()
                }.padding()
                Section(header: Text("Select Order Status")) {
                    Picker("Status", selection: $currStatus) {
                        ForEach(statusTypes, id: \.self) {
                            Text($0.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                    Spacer()
                    Button(action: {
                        viewModel.saveStatus(currStatus)
                    }, label: {
                        Text("Confirm Status").padding([.leading, .trailing], 50)
                            .padding([.top, .bottom], 15)
                            .foregroundColor(.white).background(Color.blue)
                            .cornerRadius(8.0)
                    })
                }
                Spacer()
            }
        }
        .navigationTitle("\(viewModel.order.productDescription)")
    }
    init(order: Order) {
        self.currStatus = order.currentStatus
        viewModel = OrderDetailsViewModel(order: order)
    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView(order: Order.dummyData)
    }
}
