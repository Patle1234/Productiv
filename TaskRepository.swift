//
//  TaskRepository.swift
//  Productiv (iOS)
//
//  Created by Dev Patel on 10/3/21.
//

//communicates between firestore database and front-end

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject{
    
    let database = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init(){
        loadData()
    }
    
    func loadData(){
        let userID=Auth.auth().currentUser?.uid
        print("current userID: \(userID) ")
        database.collection("todos")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo:userID)
            .addSnapshotListener{(querySnapshot,error) in //calling the collection and getting a snapshot
            if let querySnapshot = querySnapshot{
                print("in here")
                self.tasks=querySnapshot.documents.compactMap{ document in
                    do{
                        let x=try document.data(as: Task.self)
                        print("x data: \(x)")
                        return x
                    }catch{
                        print(error)
                        print("nope")
                    }
                    return nil
                }
            }
        }
    }
    
    
    
    
    func addTask(_ task:Task){
        print("went in add task for firebase")
        do{
           var addedTask=task
           addedTask.userId=Auth.auth().currentUser?.uid
           let _=try database.collection("todos").addDocument(from: addedTask)//from: addedTask
        }catch{
            fatalError("unable to encode task\(error.localizedDescription)")
        }
    }
    
//    func deleteTask(_ task :Task){
//        do{
//            var deleteTask=task
//            var x=deleteTask.userId
//            x=Auth.auth().currentUser?.uid
//            let _=try database.collection("todos").document(deleteTask.userId).delete()
//
//        }catch{
//            print(error)
//        }
//    }
    
    
    func updateTask(_ task:Task){
        if let taskID=task.id{
            do{
                try database.collection("todos").document(taskID).setData(from: task)
            }catch{
                print(error)
            }
        }
    }
    
    func delteHabit(_ task:Task){
        if let taskID=task.id{
            do{
                try database.collection("todos").document(taskID).delete()
            }catch{
                print(error)
            }
        }
    }
}

