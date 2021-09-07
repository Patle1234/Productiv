//
//  TaskCellViewModel.swift
//  
//
//  Created by Dev Patel on 7/20/21.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable{
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
            .map{task in
                task.id
            }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
        
        
    }
}
