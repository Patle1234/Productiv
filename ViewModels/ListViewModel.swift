//
//  ListViewModel.swift
//  
//
//  Created by Dev Patel on 7/20/21.
//

import Foundation
import Combine

class ListViewModel: ObservableObject{//list of all of the tasks on the screen
    @Published var TaskCellViewModels = [TaskCellViewModel]()
    @Published var taskRepository=TaskRepository()

    private var cancellable = Set<AnyCancellable>()
    
    init(){
        taskRepository.$tasks
            .map{tasks in//adding our tasks to TCVM
            tasks.map{task in
                TaskCellViewModel(task:task)
            }
        }
         .assign(to: \.TaskCellViewModels,on:self)
        .store(in: &cancellable)
    }
    
    
    func addTask(task: Task){//adds a task to the ViewModel
        print("in?")
        taskRepository.addTask(task)
        
        print("taskName: \(task.taskName)")
        
        let taskVM = TaskCellViewModel(task: task)
        self.TaskCellViewModels.append(taskVM)
    }
    
    func deleteTask(task: Task){
        taskRepository.delteHabit(task)
        let taskVM = TaskCellViewModel(task: task)
        self.TaskCellViewModels.removeAll{$0.id==taskVM.id}
    }
    
}
