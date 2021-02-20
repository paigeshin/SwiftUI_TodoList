# Notion Link

[ToDoList - Core Data ](https://www.notion.so/ToDoList-Core-Data-a7a44c1315e244e0a8c5d5625ed77488)

[Todo List UILibrary](https://www.notion.so/Todo-List-UILibrary-1643e5f4fbfd4606ac5d86f9f0ed3da7)

# How to implement Core data

- Click on Core Data when Creating an application

# What is Core Data?

Core Data is a framework that we use to manage the model layer objects in our application. It provides generalized and automated solutions to common tasks management, including persistence, saving, fetching, sorting data in the local storage.

# How to use Core Data

### AppDelegate & SceneDelegate

- When you opt in CoreData when creating a new project, it will have additional code base in `AppDelegate.swift`

```swift
//
//  AppDelegate.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TodoList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
```

```swift
//
//  SceneDelegate.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = ContentView().environment(\.managedObjectContext, context)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
```

### Create Entity

- Tap on `Add Entity`

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/89f93c1d-890c-4ac0-9931-2673ae4d7942/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/89f93c1d-890c-4ac0-9931-2673ae4d7942/Untitled.png)

### Add Attributes

- Todo (Entity)
    - priority: String (Attribute)
    - id: UUID (Attribute)
    - name: String (Attribute)

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b5d98375-774c-416f-b18d-9ea856983fc3/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b5d98375-774c-416f-b18d-9ea856983fc3/Untitled.png)

### Create Operation

```swift
@Environment(\.managedObjectContext) var managedObjectContext
AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
@Environment(\.managedObjectContext) var managedObjectContext
              
let todo = Todo(context: self.managedObjectContext)
todo.name = self.name
todo.priority = self.priority

do {
    // 5. CORE DATA: Save it into Database
    try self.managedObjectContext.save()
    print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
} catch {
    print(error)
}

```

```swift
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
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List(0 ..< 5) { item in
                Text("Hello, world!")
            } //: LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // Show add todo view
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                } //: ADD BUTTON
                .sheet(isPresented: $showingAddTodoView) {
                    //2. CORE DATA: attach environment object
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        } //: NAVIGATION
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
```

```swift
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
    
    // MARK: - BODY
    let priorities = ["High", "Normal", "Low"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    // MARK: - TODO NAME
                    TextField("Todo", text: $name)
                    
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
                                print("New todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
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
                    }) //: SAVE BUTTON 
                    
                } //: FORM
                
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
        } //: NAVIGATION
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
```

### Fetch Data

```swift
@FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
List {
    ForEach(self.todos, id: \.self) { todo in
        HStack {
            Text(todo.name ?? "Unknown")
            Spacer()
            Text(todo.priority ?? "Unknown")
        }
    } //: FOREACH
} //: LIST
```

```swift
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
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                } //: FOREACH
            } //: LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // Show add todo view
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                } //: ADD BUTTON
                .sheet(isPresented: $showingAddTodoView) {
                    //2. CORE DATA: attach environment object
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        } //: NAVIGATION
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
```

### Preview with data

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //preview with data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView()
            .environment(\.managedObjectContext, context)
            .previewDevice("iPhone 11 Pro")
    }
}
```

### Delete Operation

```swift
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
```

```swift
List {
    ForEach(self.todos, id: \.self) { todo in
        HStack {
            Text(todo.name ?? "Unknown")
            Spacer()
            Text(todo.priority ?? "Unknown")
        }
    } //: FOREACH
    .onDelete(perform: deleteTodo)
} //: LIST
```

```swift
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
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                } //: FOREACH
                .onDelete(perform: deleteTodo)
            } //: LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    // Show add todo view
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                } //: ADD BUTTON
                .sheet(isPresented: $showingAddTodoView) {
                    //2. CORE DATA: attach environment object
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        } //: NAVIGATION
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
```

### Edit

`EditButton()` ⇒ built-in swift UI component

```swift
.navigationBarItems(
                leading: EditButton(), //SwiftUI, built-in component
                trailing: Button(action: {
                    // Show add todo view
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                } //: ADD BUTTON
                .sheet(isPresented: $showingAddTodoView) {
                    //2. CORE DATA: attach environment object
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
```

```swift
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
    
    @State private var showingAddTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                } //: FOREACH
                .onDelete(perform: deleteTodo)
            } //: LIST
            .navigationBarTitle("Todo", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(), //SwiftUI, built-in component
                trailing: Button(action: {
                    // Show add todo view
                    self.showingAddTodoView.toggle()
                }) {
                    Image(systemName: "plus")
                } //: ADD BUTTON
                .sheet(isPresented: $showingAddTodoView) {
                    //2. CORE DATA: attach environment object
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        } //: NAVIGATION
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
```

# Alternate Icons - User Selected Icons

# Info.plist

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/965d8d6d-6ec5-4653-a554-305e2002e0f6/Screen_Shot_2021-02-21_at_12.43.37_AM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/965d8d6d-6ec5-4653-a554-305e2002e0f6/Screen_Shot_2021-02-21_at_12.43.37_AM.png)

`delete` Newsstand Icon 

- Icon files (iOS5)
    - Primary Icon
        - Icon files
            - Item 0: `${fileName}`

### Info.plist code

- Icon name must match file name

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/22168815-8c9f-478f-997a-23c39795e376/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/22168815-8c9f-478f-997a-23c39795e376/Untitled.png)

```xml
<key>CFBundleIcons</key>
	<dict>
		<key>CFBundleAlternateIcons</key>
		<dict>
			<key>Blue Dark</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Blue Dark</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Blue Light</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Blue Light</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Green</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Green</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Green Dark</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Green Dark</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Green Light</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Green Light</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Pink</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Pink</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Pink Dark</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Pink Dark</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Pink Light</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Pink Light</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
		</dict>
		<key>CFBundlePrimaryIcon</key>
		<dict>
			<key>CFBundleIconFiles</key>
			<array>
				<string>Blue</string>
			</array>
			<key>UIPrerenderedIcon</key>
			<false/>
		</dict>
	</dict>
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>$(DEVELOPMENT_LANGUAGE)</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIcons</key>
	<dict>
		<key>CFBundleAlternateIcons</key>
		<dict>
			<key>Blue Dark</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Blue Dark</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Blue Light</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Blue Light</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Green</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Green</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Green Dark</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Green Dark</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Green Light</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Green Light</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Pink</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Pink</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Pink Dark</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Pink Dark</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>Pink Light</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>Pink Light</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
		</dict>
		<key>CFBundlePrimaryIcon</key>
		<dict>
			<key>CFBundleIconFiles</key>
			<array>
				<string>Blue</string>
			</array>
			<key>UIPrerenderedIcon</key>
			<false/>
		</dict>
	</dict>
	<key>CFBundleIdentifier</key>
	<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>$(PRODUCT_NAME)</string>
	<key>CFBundlePackageType</key>
	<string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UIApplicationSceneManifest</key>
	<dict>
		<key>UIApplicationSupportsMultipleScenes</key>
		<false/>
		<key>UISceneConfigurations</key>
		<dict>
			<key>UIWindowSceneSessionRoleApplication</key>
			<array>
				<dict>
					<key>UISceneConfigurationName</key>
					<string>Default Configuration</string>
					<key>UISceneDelegateClassName</key>
					<string>$(PRODUCT_MODULE_NAME).SceneDelegate</string>
				</dict>
			</array>
		</dict>
	</dict>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIRequiredDeviceCapabilities</key>
	<array>
		<string>armv7</string>
	</array>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
</dict>
</plist>
```

### Info.plist Result

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ce58aa94-5295-4ed2-abd4-bfec11fa7335/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ce58aa94-5295-4ed2-abd4-bfec11fa7335/Untitled.png)

![https://s3-us-west-2.amazonaws.com/secure.notion-static.com/02b00136-cb05-4e23-a599-24ed34576771/Untitled.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/02b00136-cb05-4e23-a599-24ed34576771/Untitled.png)

### Decode Info.plist  (Environment Object)

```swift
//
//  IconNames.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/21.
//

import Foundation
import SwiftUI

// MARK: - ALTERNATE ICONS
class IconNames: ObservableObject {
    var iconNames: [String?] = [nil]
    @Published var currentIndex = 0
    
    init() {
        getAlternateIconNames()
        if let currentIcon = UIApplication.shared.alternateIconName {
            self.currentIndex = iconNames.firstIndex(of: currentIcon) ?? 0
        }
    }
    
    //decode info.plist files for getting `alternate` icon names
    func getAlternateIconNames() {
        if let icons = Bundle.main.object(forInfoDictionaryKey: "CFBundleIcons") as? [String: Any],
           let alternateIcons = icons["CFBundleAlternateIcons"] as? [String: Any] {
            for(_, value) in alternateIcons {
                guard let iconList = value as? Dictionary<String, Any> else { return }
                guard let iconFiles = iconList["CFBundleIconFiles"] as? [String] else { return }
                guard let icon = iconFiles.first else { return }
                iconNames.append(icon)
            }
        }
    }
    
}
```

### Attach Environment Object

```swift
if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(IconNames()))
            self.window = window
            window.makeKeyAndVisible()
        }
```

```swift
//
//  SceneDelegate.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = ContentView().environment(\.managedObjectContext, context)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(IconNames()))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
```

### Logic

```swift
// MARK: - SECTION 1, Choose the app icon
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .strokeBorder(Color.primary, lineWidth: 2)
                                        
                                        Image(systemName: "paintbrush")
                                            .font(.system(size: 28, weight: .regular, design: .default))
                                            .foregroundColor(Color.primary)
                                    }
                                    .frame(width: 44, height: 44)
                                    
                                    Text("App Icons".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.primary)
                                }
                               , content: {
                                ForEach(0..<iconSettings.iconNames.count) { index in
                                    HStack {
                                        Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage()
                                        )
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(8)
                                        
                                        Spacer().frame(width: 8)
                                        
                                        Text(self.iconSettings.iconNames[index] ?? "Blue")
                                            .frame(alignment: .leading)
                                        
                                    } //: HSTACK
                                    .padding(3)
                                } //: PICKER
                                // Picker Selection
                                .onReceive([self.iconSettings.currentIndex].publisher.first(), perform: { value in
                                    let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                    if index != value {
                                        UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                            } else {
                                                print("Success! You have changed the app icon.")
                                            }
                                            
                                        }
                                    }
                                })
                               })
                    } //: SECTION 1
                    .padding(.vertical, 3)
```

```swift
//
//  SettingsView.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0, content: {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 1, Choose the app icon
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .strokeBorder(Color.primary, lineWidth: 2)
                                        
                                        Image(systemName: "paintbrush")
                                            .font(.system(size: 28, weight: .regular, design: .default))
                                            .foregroundColor(Color.primary)
                                    }
                                    .frame(width: 44, height: 44)
                                    
                                    Text("App Icons".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.primary)
                                }
                               , content: {
                                ForEach(0..<iconSettings.iconNames.count) { index in
                                    HStack {
                                        Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage()
                                        )
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(8)
                                        
                                        Spacer().frame(width: 8)
                                        
                                        Text(self.iconSettings.iconNames[index] ?? "Blue")
                                            .frame(alignment: .leading)
                                        
                                    } //: HSTACK
                                    .padding(3)
                                } //: PICKER
                                // Picker Selection
                                .onReceive([self.iconSettings.currentIndex].publisher.first(), perform: { value in
                                    let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                    if index != value {
                                        UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                            } else {
                                                print("Success! You have changed the app icon.")
                                            }
                                            
                                        }
                                    }
                                })
                               })
                    } //: SECTION 1
                    .padding(.vertical, 3)
                    
                    // MARK: - SECTION 3
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimastercla.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/paigeshin")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
                    }
                    // MARK: - SECTION 4
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatability", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "John / Jane")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } //: SECTION 4
                    .padding(.vertical, 3)
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("Copyright © All rights reserved. \nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
                
            }) //: VSTACK
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                    })
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground"))
            .edgesIgnoringSafeArea(.all)
        } //: NAVIGATION
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}
```

# Create App Theme

- 저장된 color값을 일괄적용하는 노가다라고 보면 된다.

### Define Theme Model

```swift
//
//  ThemeModel.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/21.
//

import SwiftUI

// MARK: - THEME MODEL

struct Theme: Identifiable {
    let id: Int
    let themeName: String
    let themeColor: Color
}
```

### Define Theme Data

```swift
//
//  ThemeData.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/21.
//

import SwiftUI

// MARK: - THEME DATA

let themeData: [Theme] = [
    Theme(id: 0, themeName: "Pink theme", themeColor: Color.pink),
    Theme(id: 1, themeName: "Blue Theme", themeColor: Color.blue),
    Theme(id: 2, themeName: "Green Theme", themeColor: Color.green)
]
```

### ThemeSettings (Class)

```swift
//
//  ThemeSettings.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/21.
//

import SwiftUI

// MARK: - THEME CLASS

class ThemeSettings: ObservableObject {
    //get & set
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
```

### Setting Theme

```swift
// MARK: - SECTION 2 App Theme
                    Section(header:
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(themes[self.theme.themeSettings].themeColor)
                        }
                    ) {
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        
                                        Text(item.themeName)
                                    }
                                } //: BUTTON
                                .accentColor(Color.primary)
                            }
                        } //: SECTION 2
                    }
```

```swift
//
//  SettingsView.swift
//  TodoList
//
//  Created by paigeshin on 2021/02/20.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    // MARK: - THEME
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0, content: {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 1, Choose the app icon
                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSettings.currentIndex, label:
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                                            .strokeBorder(Color.primary, lineWidth: 2)
                                        
                                        Image(systemName: "paintbrush")
                                            .font(.system(size: 28, weight: .regular, design: .default))
                                            .foregroundColor(Color.primary)
                                    }
                                    .frame(width: 44, height: 44)
                                    
                                    Text("App Icons".uppercased())
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.primary)
                                }
                               , content: {
                                ForEach(0..<iconSettings.iconNames.count) { index in
                                    HStack {
                                        Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage()
                                        )
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .cornerRadius(8)
                                        
                                        Spacer().frame(width: 8)
                                        
                                        Text(self.iconSettings.iconNames[index] ?? "Blue")
                                            .frame(alignment: .leading)
                                        
                                    } //: HSTACK
                                    .padding(3)
                                } //: PICKER
                                // Picker Selection
                                .onReceive([self.iconSettings.currentIndex].publisher.first(), perform: { value in
                                    let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                                    if index != value {
                                        UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                            if let error = error {
                                                print(error.localizedDescription)
                                            } else {
                                                print("Success! You have changed the app icon.")
                                            }
                                            
                                        }
                                    }
                                })
                               })
                    } //: SECTION 1
                    .padding(.vertical, 3)
                    
                    // MARK: - SECTION 2 App Theme
                    Section(header:
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(themes[self.theme.themeSettings].themeColor)
                        }
                    ) {
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button(action: {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                }) {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(item.themeColor)
                                        
                                        Text(item.themeName)
                                    }
                                } //: BUTTON
                                .accentColor(Color.primary)
                            }
                        } //: SECTION 2
                    }
                    
                    // MARK: - SECTION 3
                    Section(header: Text("Follow us on social media")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://swiftuimastercla.com")
                        FormRowLinkView(icon: "link", color: Color.blue, text: "Twitter", link: "https://twitter.com/paigeshin")
                        FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Courses", link: "https://www.udemy.com/user/robert-petras")
                    }
                    // MARK: - SECTION 4
                    Section(header: Text("About the application")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatability", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "John / Jane")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    } //: SECTION 4
                    .padding(.vertical, 3)
                } //: FORM
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("Copyright © All rights reserved. \nBetter Apps ♡ Less Code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
                
            }) //: VSTACK
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                    })
            )
            .navigationBarTitle("Settings", displayMode: .inline)
            .background(Color("ColorBackground"))
            .edgesIgnoringSafeArea(.all)
        } //: NAVIGATION
        //Theme Setting...
        .accentColor(themes[self.theme.themeSettings].themeColor)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}
```