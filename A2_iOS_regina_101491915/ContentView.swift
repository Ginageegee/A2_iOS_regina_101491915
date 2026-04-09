import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.productID, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    @State private var currentIndex = 0

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if products.isEmpty {
                    Text("No products found")
                        .font(.title2)
                } else {
                    let product = products[currentIndex]

                    Text("Product Details")
                        .font(.largeTitle)
                        .bold()

                    NavigationLink("View Full Product List") {
                        ProductListView()
                    }
                    .padding()
                    
                    NavigationLink("Add New Product") {
                        AddProductView()
                    }
                    .padding()
                    
                    NavigationLink("Search Products") {
                        SearchProductView()
                    }
                    .padding()

                    Text("Product ID: \(product.productID)")
                    Text("Product Name: \(product.productName ?? "")")
                    Text("Description: \(product.productDescription ?? "")")
                    Text("Price: $\(product.productPrice, specifier: "%.2f")")
                    Text("Provider: \(product.productProvider ?? "")")

                    HStack(spacing: 30) {
                        Button("Previous") {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }
                        .disabled(currentIndex == 0)

                        Button("Next") {
                            if currentIndex < products.count - 1 {
                                currentIndex += 1
                            }
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                    .padding()
                }
            }
            .padding()
            .navigationTitle("Products")
        }
    }
}
