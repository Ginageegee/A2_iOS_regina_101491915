//
//  ProductListView.swift
//  A2_iOS_regina_101491915
//
//  Created by Gina Slonimsky  on 2026-04-08.
//

import SwiftUI
import CoreData

//screen that shows all products
struct ProductListView: View {
    
    //get all products from core data
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    //styling
    var body: some View {
        List {
            ForEach(products) { product in
                VStack(alignment: .leading, spacing: 10) {
                    
                    // Product Name
                    Text(product.productName ?? "No Name")
                        .font(.headline)
                        .foregroundColor(.primary)

                    // Description label
                    Text("Description:")
                        .font(.caption)
                        .foregroundColor(.gray)

                    // Product Description
                    Text(product.productDescription ?? "No Description")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    // Price
                    Text("Price: $\(product.productPrice, specifier: "%.2f")")
                        .font(.subheadline)
                        .bold()

                    // Provider
                    Text("Provider: \(product.productProvider ?? "")")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
                .padding(.vertical, 6)
            }
        }
        .listStyle(.plain) // cleaner look
        .navigationTitle("Product List")
    }
}
