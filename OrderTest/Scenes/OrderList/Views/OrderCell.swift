//
//  ProductView.swift
//  Drawing
//
//  Created by Iulian FLorea on 7/16/21.
//

import SwiftUI
import URLImage

struct OrderCell: View {
    let order: Order
    var body: some View {
        HStack {
            if let url = URL(string: order.imageURL) {
                URLImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            } else {
                OrderPlaceholderImageView()
            }
            VStack(alignment: .leading) {
                Text("\(order.productDescription)")
                Text("Status: \(order.currentStatus.rawValue)")
            }
            Spacer()
        }
    }
}

struct OrderPlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
    }
}

struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell(order: Order.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
