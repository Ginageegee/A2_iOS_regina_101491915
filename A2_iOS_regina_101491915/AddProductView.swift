//
//  AddProductView.swift
//  A2_iOS_regina_101491915
//
//  Created by Gina Slonimsky  on 2026-04-08.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    //give access to core data to save product
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    //variables for user input
    @State private var productID = ""
    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""
    @State private var errorMessage = ""
    
    //styleing
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text("Add New Product")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                    .padding(.top)

                VStack(alignment: .leading, spacing: 15) {
                    
                    Text("Product Information")
                        .font(.headline)
                        .foregroundColor(.primary)

                    TextField("Enter Product ID", text: $productID)
                        .keyboardType(.numberPad)
                        .textFieldStyle(.roundedBorder)

                    TextField("Enter Product Name", text: $productName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Enter Product Description", text: $productDescription)
                        .textFieldStyle(.roundedBorder)

                    TextField("Enter Product Price", text: $productPrice)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)

                    TextField("Enter Product Provider", text: $productProvider)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 3)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button("Save Product") {
                    saveProduct()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 10)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Add Product")
    }
    
    //save product funstion
    private func saveProduct() {
        //check if product id is of a valid type
        guard let id = Int64(productID) else {
            errorMessage = "Please enter a valid Product ID."
            return
        }
        
        //check if price is of a vaild type
        guard let price = Double(productPrice) else {
            errorMessage = "Please enter a valid Product Price."
            return
        }

        guard !productName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Product Name cannot be empty."
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
            errorMessage = "Error saving product."
            print("Error saving product: \(error)")
        }
    }
}
