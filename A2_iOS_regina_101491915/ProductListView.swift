//
//  ProductListView.swift
//  A2_iOS_regina_101491915
//
//  Created by Gina Slonimsky  on 2026-04-08.
//

import SwiftUI
import CoreData

struct ProductListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    var body: some View {
        List {
            ForEach(products) { product in
                VStack(alignment: .leading, spacing: 6) {
                    Text(product.productName ?? "No Name")
                        .font(.headline)

                    Text(product.productDescription ?? "No Description")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Product List")
    }
}
