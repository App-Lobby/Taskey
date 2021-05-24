//
//  AppInfoView.swift
//  Taskey
//
//  Created by Mohammad Yasir on 24/05/21.
//

import SwiftUI

struct AppInfoView : View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let screenSize = UIScreen.main.bounds
    @Binding var isShown: Bool
    @Binding var firstName : String
    @Binding var lastName : String
    @Binding var showingImagePicker : Bool
    @Binding var inputImage : UIImage?
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Enter Your Name")
                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .padding(.top , 10)
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1)))
                        .cornerRadius(9)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 2, x: 0.0, y: 0.0)
                    
                    TextField("First Name", text: $firstName)
                        .padding(.leading , 12)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .disableAutocorrection(true)
                }.padding(.horizontal , 10)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1)))
                        .cornerRadius(9)
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 2, x: 0.0, y: 0.0)
                    
                    TextField("Last Name", text: $lastName)
                        .padding(.leading , 12)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        .disableAutocorrection(true)
                }.padding(.horizontal , 10)
                
                Button(action: {
                    showingImagePicker = true
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1)))
                            .cornerRadius(9)
                            .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 2, x: 0.0, y: 0.0)
                        
                        HStack {
                            
                            Image(systemName : "photo")
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                .font(.system(size: 16))
                            
                            
                            Text("Pick Image")
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                .font(.system(size: 16))
                        }
                        
                    }.padding(.horizontal , 10)
                })
                
                
            }
            .frame(height : 120)
            
            HStack(spacing: 40) {
                Button(action: {
                    let new = App(context: viewContext)
                    new.firstName = firstName
                    new.lastName = lastName
                    new.profilePhoto = inputImage?.pngData()
                    new.createdAt = Date()
                    
                    do {
                        try viewContext.save()
                        print("Saved the App Name")
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    self.isShown.toggle()
                    
                }, label: {
                    Text("Done")
                })
                Button("Cancel") {
                    self.isShown = false
                }
            }
 
            
        }
        .padding(.horizontal , 10)
        //        .padding(.vertical , 10)
        .frame(width: screenSize.width * 0.7, height: screenSize.height / 4)
        .background(
            LinearGradient(gradient: Gradient(colors: [ Color(#colorLiteral(red: 0.03334418845, green: 0.02625126296, blue: 0.05201637493, alpha: 1)) , Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: 0.0, y: 0.0)
        
    }
}
