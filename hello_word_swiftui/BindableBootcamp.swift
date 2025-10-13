//
//  BindableBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande on 13/10/25.
//

import SwiftUI

struct BindableBootcamp: View {
    var body: some View {
        ProductEditorView(viewModel: ProductEditorViewModel())
    }
}

@Observable
class Product {
    var id: UUID = UUID()
    var name: String = ""
    var price: Double = 0.0
    var description: String = ""
    var category: Category = .other
    var tags: [Tag] = []
    var imageURLs: [URL] = []
    var specifications: [Specification] = []
    var inventory: Inventory = Inventory()
    
    enum Category: String, CaseIterable, Identifiable {
        case electronics, clothing, books, home, food, other
        var id: Self { self }
    }
    
    struct Tag: Identifiable {
        let id = UUID()
        var name: String
    }
    
    struct Specification: Identifiable {
        let id = UUID()
        var name: String
        var value: String
    }
}

@Observable
class Inventory {
    var quantity: Int = 0
    var lowStockThreshold: Int = 10
    var locations: [WarehouseLocation] = []
    
    struct WarehouseLocation: Identifiable {
        let id = UUID()
        var name: String
        var stockCount: Int
    }
    
    var isLowStock: Bool {
        return quantity <= lowStockThreshold
    }
}

// MARK: - View Model with Validation Logic
@Observable
class ProductEditorViewModel {
    var product: Product = Product()
    var validationErrors: [ValidationError] = []
    var isSaving: Bool = false
    
    struct ValidationError: Identifiable {
        let id = UUID()
        let field: String
        let message: String
    }
    
    func validate() -> Bool {
        validationErrors.removeAll()
        
        // Name validation
        if product.name.isEmpty {
            validationErrors.append(ValidationError(field: "name", message: "Product name is required"))
        }
        
        // Price validation
        if product.price <= 0 {
            validationErrors.append(ValidationError(field: "price", message: "Price must be greater than zero"))
        }
        
        // Inventory validation
        if product.inventory.quantity < 0 {
            validationErrors.append(ValidationError(field: "inventory", message: "Quantity cannot be negative"))
        }
        
        // Description validation
        if product.description.isEmpty {
            validationErrors.append(ValidationError(field: "description", message: "Description is required"))
        } else if product.description.count < 10 {
            validationErrors.append(ValidationError(field: "description", message: "Description must be at least 10 characters"))
        }
        
        return validationErrors.isEmpty
    }
    
    func saveProduct() async {
        guard validate() else { return }
        
        isSaving = true
        // Simulating network delay
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
        isSaving = false
        // In a real app, this would save to a database or API
    }
}

// MARK: - Main Editor View
struct ProductEditorView: View {
    @Bindable var viewModel: ProductEditorViewModel
    @State private var activeTab = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $activeTab) {
                    BasicInfoView(viewModel: viewModel)
                        .tag(0)
                    
                    InventoryView(viewModel: viewModel)
                        .tag(1)
                    
                    SpecificationsView(viewModel: viewModel)
                        .tag(2)
                }
                .tabViewStyle(.page)
                
                // Navigation buttons
                HStack {
                    Button("Previous") {
                        if activeTab > 0 {
                            activeTab -= 1
                        }
                    }
                    .disabled(activeTab == 0)
                    
                    Spacer()
                    
                    if activeTab == 2 {
                        Button(viewModel.isSaving ? "Saving..." : "Save Product") {
                            Task {
                                await viewModel.saveProduct()
                            }
                        }
                        .disabled(viewModel.isSaving)
                    } else {
                        Button("Next") {
                            if activeTab < 2 {
                                activeTab += 1
                            }
                        }
                    }
                }
                .padding()
                
                // Display validation errors
                if !viewModel.validationErrors.isEmpty {
                    ValidationErrorsView(errors: viewModel.validationErrors)
                }
            }
            .navigationTitle("Edit Product")
        }
    }
}

// MARK: - Sub-Views for Product Editing
struct BasicInfoView: View {
    @Bindable var viewModel: ProductEditorViewModel
    
    var body: some View {
        Form {
            Section("Basic Information") {
                TextField("Product Name", text: $viewModel.product.name)
                    .foregroundStyle(.debug)
                
                Picker("Category", selection: $viewModel.product.category) {
                    ForEach(Product.Category.allCases) { category in
                        Text(category.rawValue.capitalized).tag(category)
                    }
                }
                .foregroundStyle(.debug)
                
                PriceView(viewModel: viewModel)
                
                TextEditor(text: $viewModel.product.description)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray.opacity(0.2))
                    )
                    .foregroundStyle(.debug)
            }
            
            Section("Tags") {
                TagEditorView(viewModel: viewModel)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct PriceView: View {
    @Bindable var viewModel: ProductEditorViewModel
    var body: some View {
        HStack {
            Text("$")
                .foregroundStyle(.debug)
            TextField("Price", value: $viewModel.product.price, format: .number)
                .keyboardType(.decimalPad)
                .foregroundStyle(.debug)
        }
    }
}

struct TagEditorView: View {
    @Bindable var viewModel: ProductEditorViewModel
    @State private var newTagName = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("New Tag", text: $newTagName)
                Button("Add") {
                    if !newTagName.isEmpty {
                        viewModel.product.tags.append(Product.Tag(name: newTagName))
                        newTagName = ""
                    }
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.product.tags) { tag in
                        TagView(tag: tag) {
                            viewModel.product.tags.removeAll { $0.id == tag.id }
                        }
                    }
                }
                .padding(.vertical, 5)
            }
        }
    }
}

struct TagView: View {
    let tag: Product.Tag
    let onRemove: () -> Void
    
    var body: some View {
        HStack {
            Text(tag.name)
                .padding(.leading, 8)
            
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
            }
            .padding(.trailing, 8)
        }
        .padding(.vertical, 5)
        .background(
            Capsule()
                .fill(Color.blue.opacity(0.2))
        )
    }
}

struct InventoryView: View {
    @Bindable var viewModel: ProductEditorViewModel
    @State private var newLocationName = ""
    @State private var newLocationStock = 0
    
    var body: some View {
        Form {
            Section("Inventory Details") {
                Stepper("Quantity: \(viewModel.product.inventory.quantity)",
                        value: $viewModel.product.inventory.quantity)
                
                Stepper("Low Stock Threshold: \(viewModel.product.inventory.lowStockThreshold)",
                        value: $viewModel.product.inventory.lowStockThreshold)
                
                if viewModel.product.inventory.isLowStock {
                    Text("Low stock warning!")
                        .foregroundStyle(.red)
                        .font(.caption)
                }
            }
            
            Section("Warehouse Locations") {
                ForEach(viewModel.product.inventory.locations) { location in
                    LocationRow(location: location, viewModel: viewModel)
                }
                
                VStack {
                    TextField("Location Name", text: $newLocationName)
                    
                    HStack {
                        Text("Initial Stock:")
                        Stepper("\(newLocationStock)", value: $newLocationStock, in: 0...1000)
                    }
                    
                    Button("Add Location") {
                        if !newLocationName.isEmpty {
                            viewModel.product.inventory.locations.append(
                                Inventory.WarehouseLocation(name: newLocationName, stockCount: newLocationStock)
                            )
                            newLocationName = ""
                            newLocationStock = 0
                        }
                    }
                    .disabled(newLocationName.isEmpty)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct LocationRow: View {
    let location: Inventory.WarehouseLocation
    @Bindable var viewModel: ProductEditorViewModel
    
    var body: some View {
        HStack {
            Text(location.name)
            Spacer()
            Text("Stock: \(location.stockCount)")
            Button {
                // Here we need to find and remove this specific location
                // Notice how we can update nested collection items
                if let index = viewModel.product.inventory.locations.firstIndex(where: { $0.id == location.id }) {
                    viewModel.product.inventory.locations.remove(at: index)
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
    }
}

struct SpecificationsView: View {
    @Bindable var viewModel: ProductEditorViewModel
    @State private var newSpecName = ""
    @State private var newSpecValue = ""
    
    var body: some View {
        Form {
            Section("Technical Specifications") {
                List {
                    ForEach(viewModel.product.specifications) { spec in
                        HStack {
                            Text(spec.name)
                            Spacer()
                            Text(spec.value)
                        }
                    }
                    .onDelete { indices in
                        viewModel.product.specifications.remove(atOffsets: indices)
                    }
                }
                
                VStack {
                    TextField("Specification Name", text: $newSpecName)
                    TextField("Specification Value", text: $newSpecValue)
                    
                    Button("Add Specification") {
                        if !newSpecName.isEmpty && !newSpecValue.isEmpty {
                            viewModel.product.specifications.append(
                                Product.Specification(name: newSpecName, value: newSpecValue)
                            )
                            newSpecName = ""
                            newSpecValue = ""
                        }
                    }
                    .disabled(newSpecName.isEmpty || newSpecValue.isEmpty)
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

struct ValidationErrorsView: View {
    let errors: [ProductEditorViewModel.ValidationError]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Please fix the following issues:")
                .font(.headline)
                .foregroundColor(.red)
            
            ForEach(errors) { error in
                HStack(alignment: .top) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                    Text("\(error.field.capitalized): \(error.message)")
                        .font(.caption)
                }
                .padding(.leading)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.red.opacity(0.1))
        )
        .padding()
    }
}


#Preview {
    BindableBootcamp()
}
