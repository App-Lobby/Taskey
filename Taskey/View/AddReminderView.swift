//
//  AddReminderView.swift
//  Taskey
//
//  Created by Mohammad Yasir on 24/05/21.
//

import SwiftUI

struct AddReminderView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    let screenSize = UIScreen.main.bounds
    @Binding var isShown: Bool
    @Binding var text: String
    
    var body: some View {
        
        VStack(spacing: 20) {
            Text("Message")
                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .padding(.top , 10)
            ZStack {
                
                Rectangle()
                    .foregroundColor(Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1)))
                    .cornerRadius(9)
                    .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 2, x: 0.0, y: 0.0)
                
                TextField("Task Name", text: $text)
                    .padding(.leading , 12)
                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    .disableAutocorrection(true)
            }.padding(.horizontal , 10)
            
            HStack(spacing: 40) {
                Button(action: {
                    
                    let newReminder = Reminder(context : viewContext)
                    newReminder.title = text
                    newReminder.isCompleted = false
                    newReminder.id = UUID()
                    newReminder.createdAt = Date()
                    
                    do {
                        try viewContext.save()
                        print("Reminder Saved")
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
            .padding(.bottom , 10)
        }
        .padding(.horizontal , 10)
        .frame(width: screenSize.width * 0.7, height: screenSize.height / 5.5)
        .background(
            LinearGradient(gradient: Gradient(colors: [ Color(#colorLiteral(red: 0.03334418845, green: 0.02625126296, blue: 0.05201637493, alpha: 1)) , Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .offset(y: isShown ? 0 : screenSize.height)
        .animation(.spring())
        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 3, x: 0.0, y: 0.0)
        
    }
}
