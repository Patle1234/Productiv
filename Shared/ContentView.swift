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

struct settingsView: View{//show settings
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

struct taskView: View{//show to-do list
    @State var isTaskPresented = false
    @State var isHabitPresented = false
    
    @State var newTaskName=""
    @State var newHabitName=""
    @ObservedObject var taskListVM = ListViewModel()//list object
    @ObservedObject var habitListVM=HabitListViewModel()//list object
    
    @State  var ifAddTask=false//if there are more tasks
    var onCommit: (Task) -> (Void) = { _ in}
    var body: some View {
        TabView{
            //TODO: TASK SECTION
            VStack{
                List{
                    ForEach(taskListVM.TaskCellViewModels){taskListVM in//for all of the tasks in the task list
                        TaskCell(taskCellVM: taskListVM)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {//add a task button
                        isTaskPresented.toggle()
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
            .navigationTitle("To-Do's")
            .sheet(isPresented: $isTaskPresented, content: {
                TextField("Task Name",text: $newTaskName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                
                
                Button(action: {
                    ifAddTask.toggle()
                    isTaskPresented.toggle()
                    self.taskListVM.addTask(task: Task(taskName: newTaskName, ifCompleted: false))
                    newTaskName=""
                    
                }, label: {
                    Text("Create")
                })
                
            })
            
            
            
            
            //TODO: habit section
            VStack{
                List{
                    ForEach(habitListVM.HabitCellViewModels){habitListVM in//for all of the tasks in the task list
                        HabitCell(habitCellVM:habitListVM)
                    }
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {//add a task button
                        isHabitPresented.toggle()
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
            .navigationTitle("Habits")
            .sheet(isPresented: $isHabitPresented, content: {
                TextField("Habit Name",text:$newHabitName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(Font.system(size: 25, design: .default))
                    .cornerRadius(8)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                Button(action: {
                    isHabitPresented.toggle()
                    self.habitListVM.addHabit(habit: Habit(habitName:newHabitName, ifCompleted: false, plus: 0, minus: 0))
                    newHabitName=""
                }, label: {
                    Text("Create")
                })
                
            })
        }
        .tabViewStyle(.page)
    }
}

struct HabitCell: View{
    @ObservedObject var habitCellVM: HabitCellViewModel
    @State var ifEdit=false
    var onCommit: (Habit) -> Void = { _ in }//send a task to
    @ObservedObject var habitListVM=HabitListViewModel()//list object
    
    var body: some View {
        HStack {
            
            if(habitCellVM.habit.ifCompleted){
                Image(systemName:"app.fill")
                    .foregroundColor(Color.blue)
                    .onTapGesture {//on Complete
                        habitCellVM.habit.ifCompleted.toggle()
                    }
            }else{
                Image(systemName:"app")
                    .onTapGesture {//on Complete
                        habitCellVM.habit.ifCompleted.toggle()
                    }
            }
            
            if(!ifEdit){
                Text(habitCellVM.habit.habitName)
            }else{
                TextField("enter the habit", text: $habitCellVM.habit.habitName, onCommit:{
                    
                    self.onCommit(self.habitCellVM.habit)//when the created, put the task in the main viewModel
                    ifEdit=false
                })
            }
            Spacer()
            Button(action: {
            }, label:  {
                Text("☑: \(habitCellVM.habit.plus)")
            })
                .onTapGesture {
                    habitCellVM.habit.plus+=1
                    self.habitListVM.updateHabit(habit: habitCellVM.habit)
                }
            Button(action: {
                
            }, label:  {
                Text("☒: \(habitCellVM.habit.minus)")
            })
                .onTapGesture {
                    habitCellVM.habit.minus+=1
                    self.habitListVM.updateHabit(habit: habitCellVM.habit)
                }
        }
        .contextMenu {
            Button(action: {
                self.habitListVM.deleteHabit(habit: habitCellVM.habit)
                print("running delte")
                
            }, label: {
                Text("🗑️ Delete")
            })
            
            Button(action: {
                ifEdit=true
                print("running delte")
                
            }, label: {
                Text("📝 Edit")
            })
        }
    }
}


struct TaskCell: View {//a single task
    @ObservedObject var taskListVM = ListViewModel()//list object
    @ObservedObject var taskCellVM: TaskCellViewModel
    @State var ifEdit=false
    var onCommit: (Task) -> Void = { _ in }//send a task to
    
    var body: some View {
        HStack {
            if(taskCellVM.task.ifCompleted){
                Image(systemName:"app.fill")
                    .foregroundColor(Color.blue)
                    .onTapGesture {//on Complete
                        taskCellVM.task.ifCompleted.toggle()
                    }
            }else{
                Image(systemName:"app")
                    .onTapGesture {//on Complete
                        taskCellVM.task.ifCompleted.toggle()
                    }
            }
            if(!ifEdit){
                Text(taskCellVM.task.taskName)
            }else{
                TextField("enter the task", text: $taskCellVM.task.taskName, onCommit:{
                    self.onCommit(self.taskCellVM.task)//when the created, put the task in the main viewModel
                })
            }

        }
        .contextMenu {
            Button(action: {
                self.taskListVM.deleteTask(task: taskCellVM.task)
            }, label: {
                Text("🗑️ Delete")
            })
            Button(action: {
                ifEdit=true
            }, label: {
                Text("📝 Edit")
            })
        }
    }
}




struct teamView: View{//shows the team
    var body: some View {
        VStack{
            Text("hello")
            HStack{
                Button(action: {
                    
                }, label: {
                    Text("Show LeaderBoard")
                })
                Button(action: {
                    
                }, label: {
                    Text("Show LeaderBoard")
                })
                
            }
        }
        .navigationTitle("Tasks")
    }
}

struct ContentView: View {//sets what page it is on
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

struct ContentView_Previews: PreviewProvider {//runs code
    static var previews: some View {
        ContentView()
    }
}

