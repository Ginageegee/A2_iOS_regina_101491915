import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        for i in 1...10 {
            let newProduct = Product(context: viewContext)
            newProduct.productID = Int64(i)
            newProduct.productName = "Product \(i)"
            newProduct.productDescription = "Description for product \(i)"
            newProduct.productPrice = Double(i) * 10.0
            newProduct.productProvider = "Provider \(i)"
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "A2_iOS_regina_101491915")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        self.addSampleProductsIfNeeded()
    }

    func addSampleProductsIfNeeded() {
        let viewContext = container.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let count = try viewContext.count(for: fetchRequest)
            
            if count == 0 {
                for i in 1...10 {
                    let newProduct = Product(context: viewContext)
                    newProduct.productID = Int64(i)
                    newProduct.productName = "Product \(i)"
                    newProduct.productDescription = "Description for product \(i)"
                    newProduct.productPrice = Double(i) * 10.0
                    newProduct.productProvider = "Provider \(i)"
                }
                
                try viewContext.save()
            }
        } catch {
            print("Error adding sample products: \(error)")
        }
    }
}
