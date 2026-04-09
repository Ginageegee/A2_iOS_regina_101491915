//
//  AddProductView.swift
//  A2_iOS_regina_101491915
//
//  Created by Gina Slonimsky  on 2026-04-08.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var productID = ""
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""

    var body: some View {
        Form {
            Section(header: Text("Product Info")) {
                TextField("Product ID", text: $productID)
                    .keyboardType(.numberPad)

                TextField("Product Name", text: $productName)
                TextField("Description", text: $productDescription)

                TextField("Price", text: $productPrice)
                    .keyboardType(.decimalPad)

                TextField("Provider", text: $productProvider)
            }

            Button("Save Product") {
                saveProduct()
            }
        }
        .navigationTitle("Add Product")
    }

    private func saveProduct() {
        guard let id = Int64(productID),
              let price = Double(productPrice),
              !productName.isEmpty else {
            print("Invalid input")
            return
        }

        let newProduct = Product(context: viewContext)
        newProduct.productID = id
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = price
        newProduct.productProvider = productProvider

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving product: \(error)")
        }
    }
}
