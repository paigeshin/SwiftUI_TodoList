//
//  AddTodoView.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - PROPERTIES
    
    //3. CORE DATA: declare environment object
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    // MARK: - THEME
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    // MARK: - BODY
    let priorities = ["High", "Normal", "Low"]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size:24, weight: .bold, design: .default))
                    
                    // MARK: - TODO PRIORITY, Picker View
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        
                        if self.name != "" {
                            // 4. CORE DATA: Create Obejct (Object is automatically created when you create entity with attributes)
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                // 5. CORE DATA: Save it into Database
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                        } else {
                            
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return 
                            
                        }
                        
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    }) //: SAVE BUTTON
                } //: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
                Spacer()
            } //: VSTACK
            .navigationBarTitle("New Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
            .alert(isPresented: $errorShowing, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
        //: NAVIGATION
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle()) // for mac or iPad
    }
    //Theme Setting...

    
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
