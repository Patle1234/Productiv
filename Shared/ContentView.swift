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
            print("in create")
            print("results: ", result)
            print("error: ", error)
            guard result != nil, error == nil else {
                print("what this")
                return
            }
            print("got here")
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
                Button(action: {
                    viewModel.signOut()
                }, label: {
                    Text("Sign Out")
                        .frame(width:200, height:50)
                        .background(Color.green)
                        .foregroundColor(Color.blue)
                        .padding()
                })
                
                
                Text("You are signed in")
                
               
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
                    .background(Color(.secondarySystemBackground))
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
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
                    .padding()
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                Button(action: {
                    print("?")
                    guard !email.isEmpty, !password.isEmpty else {//if the textfields are empty
                        return
                    }
                    print("reaches here")
                    print("emial:",email)
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
