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
    @State private var isThemeChanged: Bool = false
    
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
                                    self.isThemeChanged.toggle()
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
                        .padding(.vertical, 3)
                        .alert(isPresented: $isThemeChanged) {
                            Alert(
                                title: Text("SUCCESS!"),
                                message: Text("App has been changed to the \(themes[self.theme.themeSettings].themeName). Now close and restart it!"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
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
        .navigationViewStyle(StackNavigationViewStyle()) // for mac or iPad
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}