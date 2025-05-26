//
//  ContentView.swift
//  WishList
//
//  Created by V17SAshour1 on 26/05/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    @State private var isShowingAlert = false
    @State private var title = ""
    
    var body: some View {
        NavigationStack {
            List(wishes) { wish in
                Text(wish.title)
                    .font(.title2)
                    .padding(.vertical, 2)
                    .swipeActions {
                        Button("Delete", role: .destructive) {
                            modelContext.delete(wish)
                        }
                    }
            }
            .navigationTitle("Wishlist")
            .navigationBarItems(
                trailing: Button {
                    isShowingAlert.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            )
            .toolbar {
                if !wishes.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }
            }
            .alert("Create a new wish", isPresented: $isShowingAlert, ) {
                TextField("Enter a wish", text: $title)
                
                Button{
                    modelContext.insert(Wish(title: title))
                    title = ""
                } label : {
                    Text("Save")
                }
            }
            .overlay {
                if wishes.isEmpty {
                    ContentUnavailableView(
                        "My Wishlist",
                        systemImage: "heart.circle",
                        description:
                            Text("No wishes yet. Add one to get started.")
                    )
                }
            }
        }
        
    }
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}

#Preview("List with Sample Data") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Buy new macbook pro"))
    container.mainContext.insert(Wish(title: "Find a new job"))
    container.mainContext.insert(Wish(title: "Master SwiftUI"))
    container.mainContext.insert(Wish(title: "Master Swift Data"))
    container.mainContext.insert(Wish(title: "Travel to Egypt"))
    
    
    return ContentView()
        .modelContainer(container)
}
