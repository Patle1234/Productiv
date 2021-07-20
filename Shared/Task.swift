//
//  Task.swift
//  Productiv
//
//  Created by Dev Patel on 7/19/21.
//

import Foundation

struct Task: Identifiable {
    var id: String = UUID().uuidString //creates a unqiue id for each task
    var taskName: String
    var ifCompleted: Bool
}

let testDataTasks = [
    Task(taskName: "finish hw", ifCompleted: false),
    Task(taskName: "finish journalBot", ifCompleted: false),
    Task(taskName: "write debate speeches", ifCompleted: true),
    Task(taskName: "work on productiv", ifCompleted: true)

]

