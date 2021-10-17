//
//  HabitRepository.swift
//  Productiv
//
//  Created by Dev Patel on 10/14/21.
//



import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class HabitRepository: ObservableObject{
    
    let database = Firestore.firestore()
    
    @Published var habits = [Habit]()
    
    init(){
        loadData()
    }
    
    func loadData(){
        let userID=Auth.auth().currentUser?.uid
        print("current userID: \(userID) ")
        database.collection("habits")
            .order(by: "createdTime")
            .whereField("userId", isEqualTo:userID)
            .addSnapshotListener{(querySnapshot,error) in //calling the collection and getting a snapshot
            if let querySnapshot = querySnapshot{
                print("in here")
                self.habits=querySnapshot.documents.compactMap{ document in
                    do{
                        let x=try document.data(as: Habit.self)
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
    
    
    
    
    func addHabit(_ habit:Habit ){
        print("went in add task for firebase")
        do{
           var addedHabit=habit
            addedHabit.userId=Auth.auth().currentUser?.uid
           let _=try database.collection("habits").addDocument(from: addedHabit)//from: addedTask
        }catch{
            fatalError("unable to encode habits\(error.localizedDescription)")
        }
    }
    
    
    func updateHabit(_ habit:Habit){
        if let habitID=habit.id{
            do{
                try database.collection("habits").document(habitID).setData(from: habit)
            }catch{
                print(error)
            }
        }
    }
    
    
    func delteHabit(_ habit:Habit){
        if let habitID=habit.id{
            do{
                try database.collection("habits").document(habitID).delete()
            }catch{
                print(error)
            }
        }
    }
    
}

