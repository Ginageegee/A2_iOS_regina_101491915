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

                    // Title
                    Text("Product Details")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.blue)

                    // Navigation Links (Styled)
                    VStack(spacing: 10) {
                        NavigationLink("View Full Product List") {
                            ProductListView()
                        }
                        .buttonStyle(.borderedProminent)

                        NavigationLink("Add New Product") {
                            AddProductView()
                        }
                        .buttonStyle(.bordered)

                        NavigationLink("Search Products") {
                            SearchProductView()
                        }
                        .buttonStyle(.bordered)
                    }

                    // Product Card
                    VStack(alignment: .leading, spacing: 12) {
                        Text("ID: \(product.productID)")

                        Text("Name: \(product.productName ?? "")")
                            .font(.headline)

                        Text("Description:")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(product.productDescription ?? "")
                            .font(.body)

                        Text("Price: $\(product.productPrice, specifier: "%.2f")")
                            .bold()

                        Text("Provider: \(product.productProvider ?? "")")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .shadow(radius: 4)

                    // Navigation Buttons
                    HStack(spacing: 30) {
                        Button("Previous") {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }
                        .buttonStyle(.bordered)
                        .disabled(currentIndex == 0)

                        Button("Next") {
                            if currentIndex < products.count - 1 {
                                currentIndex += 1
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(currentIndex == products.count - 1)
                    }
                    .padding()

                    // Your Name + Student ID (for grading)
                    Text("Regina Slonimsky - 101491915")
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .navigationTitle("Products")
        }
    }
}
