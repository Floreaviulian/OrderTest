//
//  OrderDetailsView.swift
//  Drawing
//
//  Created by Iulian Florea on 7/16/21.
//

import SwiftUI
import URLImage

struct OrderDetailsView: View {
    let order: Order
    var statusTypes = ["new", "pending", "delivered"]
    @State var selected = Order.dummyData.status
    var body: some View {
        ScrollView {
            VStack {
                if let url = URL(string: order.imageURL) {
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
                Text("Price: \(order.price)$").padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(order.deliverTo.name)")
                    Divider()
                    Text("Address: \(order.deliverTo.address)")
                    Divider()
                    Text("Current status: \(order.status)")
                    Divider()
                }.padding()
                Section(header: Text("Select Order Status")) {
                    Picker("Status", selection: $selected) {
                        ForEach(statusTypes, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    .padding()
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Confirm Status").padding([.leading, .trailing], 50)
                            .padding([.top, .bottom], 15)
                            .foregroundColor(.white).background(Color.blue)
                            .cornerRadius(8.0)
                    })
                }
                Spacer()
            }
        }
        .navigationTitle("\(order.productDescription)")
    }
}

struct OrderDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailsView(order: Order.dummyData)
    }
}
