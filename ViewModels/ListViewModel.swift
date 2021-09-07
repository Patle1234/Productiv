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
    
    private var cancellable = Set<AnyCancellable>()
    
    init(){
        self.TaskCellViewModels = testDataTasks.map {tempTask in
            TaskCellViewModel(task: tempTask)
        }
    }
    
    
    func addTask(task: Task){//adds a task to the ViewModel
        let taskVM = TaskCellViewModel(task: task)
        self.TaskCellViewModels.append(taskVM)
    }

}
