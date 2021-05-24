//
//  ContentView.swift
//  Taskey
//
//  Created by Mohammad Yasir on 24/05/21.
//

import SwiftUI
import CoreData
import SwiftUICharts

let chartstyle = ChartStyle(backgroundColor: Color(#colorLiteral(red: 0.1895590621, green: 0.1168746242, blue: 0.4104446862, alpha: 1)).opacity(0.0), accentColor: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), secondGradientColor: Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), textColor: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.0), legendTextColor: Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)), dropShadowColor: Color(#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)))

struct ContentView: View {
    
    @State private var showSide : Bool = false
    @State private var showAddView : Bool = false
    @State private var searched : String = ""
    @State private var isSearching = false
    @State private var isCompleted = false
    @State private var title : String = ""
    @State private var appOwnerFirstName : String = "My"
    @State private var appOwnerLastName : String = "Friend"
    @State private var showOwnerNameView : Bool = false
    @State private var showingImagePicker : Bool = false
    @State private var inputImage : UIImage?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Reminder.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Reminder.createdAt, ascending: true)])
    var reminders: FetchedResults<Reminder>
    
    @FetchRequest(entity: App.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \App.createdAt, ascending: true)])
    var app: FetchedResults<App>
    
    var body: some View {
        ZStack (alignment:.leading){
            Image("back")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack(alignment:.leading , spacing : 30){
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)){
                            showSide = false
                        }
                        
                    }, label: {
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 2.0)
                                .foregroundColor(Color(#colorLiteral(red: 0.2192850067, green: 0.2825516116, blue: 0.4862745106, alpha: 1)).opacity(0.5))
                            
                            Image(systemName: "arrow.left")
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.7))
                            
                        }
                        .frame(width: 50, height: 50, alignment: .center)
                    })
                }
                ZStack {
                    Circle()
                        .stroke(lineWidth: 3.0)
                        .foregroundColor(Color(#colorLiteral(red: 0.2192850067, green: 0.2825516116, blue: 0.4862745106, alpha: 1)))
                    
                    
                    Circle()
                        .trim(from: 0.0, to: 0.43)
                        .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 0.1126264818, blue: 0.9802823481, alpha: 1)))
                        .rotationEffect(.degrees(-90))
                    
                    let n = app.count - 1
                    if app.count != 0 && app[n].profilePhoto != nil {
                        Image(uiImage: UIImage(data: app[n].profilePhoto!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90, alignment: .center)
                            .clipShape(Circle())
                    } else {
                        Image("pic")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 90, height: 90, alignment: .center)
                            .clipShape(Circle())
                    }
                    
                    
                }
                .frame(width: 100, height: 100, alignment: .center)
                .padding(.top , -30)
                .onTapGesture {
                    // Navigate Image Picker
                    showOwnerNameView = true
                }
                
                
                
                VStack(alignment:.leading , spacing : 9){
                    
                    if app.count == 0 {
                        Text("Welcome")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        Text("There !")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    } else {
                        let n = app.count - 1
                        Text("\(app[n].firstName!)")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                        Text("\(app[n].lastName!)")
                            .font(.system(size: 35, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    
                }
                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                
                
                VStack(alignment:.leading , spacing : 28){
                    HStack(spacing : 10){
                        Image(systemName: "bookmark")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.6174810868, green: 0.6174810868, blue: 0.6174810868, alpha: 1)))
                        Text("Templates")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.7))
                    }
                    HStack(spacing : 10){
                        Image(systemName: "rectangle.stack.person.crop")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.6174810868, green: 0.6174810868, blue: 0.6174810868, alpha: 1)))
                        Text("Categories")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.7))
                    }
                    HStack(spacing : 10){
                        Image(systemName: "clock")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 0.6174810868, green: 0.6174810868, blue: 0.6174810868, alpha: 1)))
                        Text("Analytics")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).opacity(0.7))
                    }
                }
                
                MultiLineChartView(data: [([8,32,11,23,40,28], GradientColors.orngPink)], title: "Chart" , style: chartstyle)
                
                VStack(alignment:.leading){
                    Text("Good")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color(#colorLiteral(red: 0.1577721556, green: 0.5591396708, blue: 1, alpha: 0.4831928454)))
                    Text("Consistancy")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                }
                
            }
            .frame(width: UIScreen.main.bounds.width / 1.9, height: UIScreen.main.bounds.height, alignment: .center)
            .padding(.leading , 40)
            .blur(radius: showSide ? 0 : 3)
            
            
            VStack {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [ Color(#colorLiteral(red: 0.03529411765, green: 0.02745098039, blue: 0.05098039216, alpha: 1)) , Color(#colorLiteral(red: 0.1494468771, green: 0.06504140199, blue: 0.2321173555, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    VStack(alignment : .leading){
                        
                        VStack(alignment : .leading , spacing : 10){
                            Text("What's up,")
                                .font(.system(size: 35, weight: .bold, design: .rounded))
                                .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            if app.count == 0 {
                                Text("My Freind")
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            } else {
                                let n = app.count - 1
                                Text("\(app[n].firstName!) \(app[n].lastName!)")
                                    .font(.system(size: 35, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            }
                            
                            
                        }
                        .padding(.top , 20)
                        
                        HStack {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)){
                                    showSide = true
                                }
                            }, label: {
                                Image("side")
                                    .resizable()
                                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.7))
                                    .frame(width:20 , height : 10)
                            })
                            
                            SearchView(searched: $searched, isSearching: $isSearching)
                                .padding(.trailing , 7)
                            
                            
                        }
                        .padding(.top , 20)
                        
                        
                        Text("YOUR TASKS")
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                            .font(.system(size: 12, weight: .medium, design: .rounded))
                            .padding(.top , 15)
                        
                        ScrollView(.vertical , showsIndicators: false) {
                            VStack(spacing : 12){
                                ForEach(reminders.indices , id: \.self) { i in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .foregroundColor(Color(#colorLiteral(red: 0.06194570952, green: 0.08552871368, blue: 0.2766906481, alpha: 1)))
                                        
                                        HStack(spacing : 18){
                                            Button(action: {
                                                if reminders[i].isCompleted == true {
                                                    reminders[i].isCompleted = false
                                                    viewContext.performAndWait {
                                                        reminders[i].isCompleted = false
                                                        try? viewContext.save()
                                                        print("Reminder Updated")
                                                    }
                                                } else {
                                                    reminders[i].isCompleted = true
                                                    viewContext.performAndWait {
                                                        reminders[i].isCompleted = true
                                                        try? viewContext.save()
                                                        print("Reminder Updated")
                                                    }
                                                }
                                            }, label: {
                                                if reminders[i].isCompleted {
                                                    ZStack {
                                                        Image(systemName: "circle.fill")
                                                            .foregroundColor(Color(#colorLiteral(red: 0.2295567705, green: 0.1456311053, blue: 0.4030385722, alpha: 1)))
                                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                                        
                                                        Image(systemName: "checkmark")
                                                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                                            .font(.system(size: 8, weight: .bold, design: .rounded))
                                                    }
                                                } else {
                                                    Image(systemName: "circle")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                                }
                                            })
                                            
                                            
                                            
                                            ZStack {
                                                HStack {
                                                    Text(reminders[i].title!)
                                                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                                    Spacer()
                                                }
                                                
                                                if reminders[i].isCompleted {
                                                    Rectangle()
                                                        .frame(height : 0.5)
                                                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                                }
                                            }
                                            
                                            if reminders[i].isCompleted {
                                                Button(action: {
                                                    for j in 0..<reminders.count {
                                                        if j == i {
                                                            viewContext.delete(reminders[j])
                                                        }
                                                    }
                                                    viewContext.delete(reminders[i])
                                                    do {
                                                        try viewContext.save()
                                                        print("Reminder Deleted")
                                                    } catch {
                                                        print(error.localizedDescription)
                                                    }
                                                }, label: {
                                                    Image(systemName:"trash")
                                                        .foregroundColor(Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)))
                                                })
                                                
                                            }
                                            
                                            Spacer()
                                            
                                        }.padding(.leading , 16)
                                    }
                                    .frame(height : 65)
                                }
                                
                            }
                        }
                        
                        Spacer()
                        
                        
                    }
                    .frame(width: UIScreen.main.bounds.width - 35, height: UIScreen.main.bounds.height - 100, alignment: .center)
                }
                
            }
            .cornerRadius(30)
            .offset(x : showSide ? UIScreen.main.bounds.width / 1.5 : 0)
            .ignoresSafeArea(edges: showSide ? .leading : .all  )
            .frame(width: UIScreen.main.bounds.width, height: showSide ? UIScreen.main.bounds.height - 100 : UIScreen.main.bounds.height, alignment: .center)
            .blur(radius: showSide ? 3 : 0)
            
            // Showing Side Menu
            if !showSide {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation{
                                showAddView.toggle()
                            }
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25.0)
                                    .foregroundColor(Color(#colorLiteral(red: 0.6037809657, green: 0.08106320753, blue: 1, alpha: 1)))
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                            .frame(width : 50 ,height : 50)
                        })
                    }
                }
                .padding(.vertical , 30)
                .padding(.horizontal , 30)
            }
            
            // Showing Add View
            if showAddView {
                HStack {
                    Spacer()
                    AddReminderView(isShown: $showAddView, text: $title)
                        .environment(\.managedObjectContext, self.viewContext)
                    Spacer()
                }
            }
            
            // Showing Profile Editing View
            if showOwnerNameView {
                HStack {
                    Spacer()
                    AppInfoView(isShown: $showOwnerNameView, firstName: $appOwnerFirstName, lastName: $appOwnerLastName , showingImagePicker : $showingImagePicker , inputImage : $inputImage )
                        .environment(\.managedObjectContext, self.viewContext)
                    Spacer()
                }
            }
            
            
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$inputImage)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}













