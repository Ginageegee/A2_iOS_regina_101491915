import SwiftUI
import CoreData

//screen for searching products
struct SearchProductView: View {
    // gives access to Core Data (database)
    @Environment(\.managedObjectContext) private var viewContext
    
    // stores what the user types into the search box
    @State private var searchText = ""
    // stores the search results
    @State private var results: [Product] = []
    
    //styling
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Search Products")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
                .padding(.top)

            VStack(spacing: 12) {
                HStack {
                    TextField("Search by name or description", text: $searchText)
                        .textFieldStyle(.roundedBorder)

                    Button("Search") {
                        searchProducts()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal)

            if results.isEmpty {
                Spacer()
                Text("No matching products found")
                    .foregroundColor(.gray)
                    .font(.headline)
                Spacer()
            } else {
                List {
                    ForEach(results, id: \.objectID) { product in
                        VStack(alignment: .leading, spacing: 10) {
                            
                            Text(product.productName ?? "No Name")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Description:")
                                .font(.caption)
                                .foregroundColor(.gray)

                            Text(product.productDescription ?? "No Description")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Price: $\(product.productPrice, specifier: "%.2f")")
                                .font(.subheadline)
                                .bold()

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
                .listStyle(.plain)
            }
        }
        .padding(.bottom)
        .navigationTitle("Search Products")
    }
    
    // Function to search products in Core Data
    private func searchProducts() {
        // Create a fetch request
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        //If search box is empty, clear results
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            results = []
            return
        }
        
        // Filter results where name OR description contains the search text
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
