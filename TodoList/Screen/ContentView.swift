//
//  ContentView.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    
    //1. CORE DATA: declare environment object
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @EnvironmentObject var iconSettings: IconNames
    
    @State private var showingSettingsView: Bool = false
    @State private var showingAddToDoView: Bool = false
    @State private var animatingButton: Bool = false
    
    // MARK: - THEME
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Circle()
                                .frame(width: 12, height: 12, alignment: .center)
                                .foregroundColor(self.colorize(priority: todo.priority ?? "Normal"))
                            
                            Text(todo.name ?? "Unknown")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(todo.priority ?? "Unknown")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(2)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                        } //: HSTACK
                        .padding(.vertical, 10)
                    } //: FOREACH
                    .onDelete(perform: deleteTodo)
                } //: LIST
                .navigationBarTitle("Todo", displayMode: .inline)
                .navigationBarItems(
                    leading: EditButton().accentColor(themes[self.theme.themeSettings].themeColor), //SwiftUI, built-in component
                    trailing: Button(action: {
                        // Show add todo view
                        self.showingSettingsView.toggle()
                    }) {
                        Image(systemName: "paintbrush")
                            .imageScale(.large)
                    } //: ADD BUTTON
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                    .sheet(isPresented: $showingSettingsView) {
                        SettingsView()
                            .environmentObject(self.iconSettings)
                    }
                )
                
                // MARK: - NO TODO ITEMS
                if todos.count == 0 {
                    EmptyListView()
                }

            } //: ZSTACK
            .sheet(isPresented: $showingAddToDoView) {
                //2. CORE DATA: attach environment object
                AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                    }
//                    .animation(
//                        Animation.linear(duration: 2)
//                            .repeatForever(autoreverses: false)
//                    )
                    
                    Button(action: {
                        self.showingAddToDoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                    } //: BUTTON
                    .accentColor(themes[self.theme.themeSettings].themeColor)
                    .onAppear(perform: {
                        self.animatingButton.toggle()
                    })
                } //: ZSTACK
                .padding(.bottom, 15)
                .padding(.trailing, 15),
                alignment: .bottomTrailing
            )
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle()) // for mac or iPad
    }
    
    // MARK: - FUNCTIONS
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - COLORIZE
    private func colorize(priority: String) -> Color {
        switch priority {
        case "High":
            return .pink
        case "Normal":
            return .green
        case "Low":
            return .blue
        default:
            return .gray
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //preview with data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
            .previewDevice("iPhone 11 Pro")
    }
}
