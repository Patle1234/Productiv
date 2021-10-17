//
//  Daily.swift
//  Productiv (iOS)
//
//  Created by Dev Patel on 10/15/21.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Daily: Codable,Identifiable {//somthings is codable is everything inside(pritives) are codeable
    @DocumentID var id: String? //creates a unqiue id for each task. DocumentID,tells firestore to add id to this field
    var taskName: String
    var ifCompleted: Bool
    @ServerTimestamp var createdTime: Timestamp?//whenever user timestamp is null, will create a timestamp
    var userId:String?
}
