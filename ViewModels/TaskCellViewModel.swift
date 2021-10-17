//
//  TaskCellViewModel.swift
//  
//
//  Created by Dev Patel on 7/20/21.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable{
    @Published var taskRepo=TaskRepository()
    @Published var task: Task
    var id:String = ""
    private var cancellable = Set<AnyCancellable>()
    var ifCompletedIcon: String = ""
    
    init(task: Task){
        self.task=task
        $task
            .map{task in
                task.ifCompleted ? "app.fill" : "sqaure"
            }
            .assign(to: \.ifCompletedIcon, on: self)
            .store(in: &cancellable)
        $task
            .compactMap{task in
                task.id
            }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
        
        $task
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)//only sends to Firestore every .8 secs
            .sink{task in
                self.taskRepo.updateTask(task)
            }
            .store(in: &cancellable)
        
        print("created")
        
    }
    static func newTask() -> TaskCellViewModel {
      TaskCellViewModel(task: Task(taskName: "",ifCompleted: false))
    }
}
