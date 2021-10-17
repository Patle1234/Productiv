//
//  Task.swift
//  Productiv
//
//  Created by Dev Patel on 7/19/21.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Task: Codable,Identifiable {//somthings is codable is everything inside(pritives) are codeable
    @DocumentID var id: String? //creates a unqiue id for each task. DocumentID,tells firestore to add id to this field
    var taskName: String
    var ifCompleted: Bool
    @ServerTimestamp var createdTime: Timestamp?//whenever user timestamp is null, will create a timestamp
    var userId:String?
}

//let testDataTasks = [
//    Task(taskName: "finish hw", ifCompleted: false),
//    Task(taskName: "finish journalBot", ifCompleted: false),
//    Task(taskName: "write debate speeches", ifCompleted: true),
//    Task(taskName: "work on productiv", ifCompleted: true)
//
//]
//
