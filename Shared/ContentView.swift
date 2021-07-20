//
//  ContentView.swift
//  Shared
//
//  Created by Dev Patel on 7/6/21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth=Auth.auth()
    
    @Published var signedIn=false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil//if the user does or doesn't have a account
    }
    
    func signIn(email: String, password:String){
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //Sign up success
            DispatchQueue.main.async {
                self?.signedIn=true
            }
        }
    }
    
    func signUp(email: String, password:String){
        print("hereadffewarte")
        auth.createUser(withEmail: email,
                        password: password) { [weak self]  result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn=true
            }
        }
    }
    
    func signOut(){
        try? auth.signOut()
        self.signedIn=false
    }
}
struct ContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                mainView()
            }else{
                SignInView()

            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}



struct SignInView: View {
    @State var email=""
    @State var password=""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height:150 )
            VStack{
                TextField("Email Address",text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {//if the textfields are empty
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Sign In")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(8)
                                    
                })
                NavigationLink("Create Account", destination: SignUpView())
                    .padding()
            }
            .padding()
        }
        .navigationTitle("Sign In")
    }
}

struct SignUpView: View {
    @State var email=""
    @State var password=""
    @State var firstName=""
    @State var lastName=""

    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height:150 )
            VStack{
                TextField("Email Address",text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .padding()
                
                Button(action: {
                    print("?")
                    guard !email.isEmpty, !password.isEmpty else {//if the textfields are empty
                        return
                    }
                    viewModel.signUp(email: email, password: password)
                }, label: {
                    Text("Sign Up")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50, alignment: .center)
                        .background(Color.blue)
                        .cornerRadius(8)
                    
                    
                })
                
            }
            .padding()
        }
        .navigationTitle("Create Account")
    }
}

struct mainView: View {
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        TabView{
            taskView()
            .tabItem({
                Image(systemName:"list.bullet")
            })
            teamView()
                .tabItem({
                    Image(systemName:"person.3.fill")
                    Text("Team")
                })
            settingsView()
                .tabItem({
                    Image(systemName:"gear")
                    Text("Setttings")
                })
        }
        
        
    }
}

struct settingsView: View{
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        VStack{
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign Out")
                    .frame(width:250, height:75)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(8)
                    .padding()
            })
        }
        .navigationTitle("Setttings")
    }
}

struct taskView: View{
    let task = testDataTasks
    var body: some View {
        NavigationView{
            VStack{
                List(task){task in
                    if(task.ifCompleted){
                        Image(systemName:"app.fill")
                    }else{
                        Image(systemName:"app")
                    }
                    Text(task.taskName)
                }
                
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Text("+")
                            .font(.system(.largeTitle))
                            .frame(width: 77, height: 70)
                            .foregroundColor(Color.white)
                            .padding(.bottom, 7)
                    })
                    .background(Color.blue)
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

struct teamView: View{
    var body: some View {
        VStack{

        }
        .navigationTitle("Tasks")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
