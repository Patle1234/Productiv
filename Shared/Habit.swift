//
//  Habit.swift
//  Productiv
//
//  Created by Dev Patel on 10/14/21.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore
import grpc

struct Habit: Codable,Identifiable {//somthings is codable is everything inside(pritives) are codeable
    @DocumentID var id: String? //creates a unqiue id for each task. DocumentID,tells firestore to add id to this field
    var habitName: String
    var ifCompleted: Bool
    var plus:Int
    var minus:Int
    @ServerTimestamp var createdTime: Timestamp?//whenever user timestamp is null, will create a timestamp
    var userId:String?

}
