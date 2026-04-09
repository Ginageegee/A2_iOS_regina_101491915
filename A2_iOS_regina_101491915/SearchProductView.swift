import SwiftUI
import CoreData

struct SearchProductView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var searchText = ""
    @State private var results: [Product] = []

    var body: some View {
        VStack {
            HStack {
                TextField("Search by name or description", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Search") {
                    searchProducts()
                }
            }
            .padding()

            if results.isEmpty {
                Spacer()
                Text("No matching products found")
                    .foregroundColor(.gray)
                Spacer()
            } else {
                List {
                    ForEach(results, id: \.objectID) { product in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(product.productName ?? "No Name")
                                .font(.headline)

                            Text(product.productDescription ?? "No Description")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            Text("Price: $\(product.productPrice, specifier: "%.2f")")
                            Text("Provider: \(product.productProvider ?? "")")
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Search Products")
    }

    private func searchProducts() {
        let request: NSFetchRequest<Product> = Product.fetchRequest()

        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            results = []
            return
        }

        request.predicate = NSPredicate(
            format: "productName CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@",
            searchText,
            searchText
        )

        request.sortDescriptors = [NSSortDescriptor(key: "productID", ascending: true)]

        do {
            results = try viewContext.fetch(request)
        } catch {
            print("Search failed: \(error)")
        }
    }
}
