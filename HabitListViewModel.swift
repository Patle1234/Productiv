//
//  HabitListViewModel.swift
//  Productiv
//
//  Created by Dev Patel on 10/14/21.
//


import Foundation
import Combine

class HabitListViewModel: ObservableObject{//list of all of the tasks on the screen
    @Published var HabitCellViewModels = [HabitCellViewModel]()
    @Published var habitRepository=HabitRepository()

    private var cancellable = Set<AnyCancellable>()
    
    init(){
        habitRepository.$habits
            .map{habits in//adding our tasks to TCVM
            habits.map{habit in
                HabitCellViewModel(habit: habit)
            }
        }
         .assign(to: \.HabitCellViewModels,on:self)
        .store(in: &cancellable)
    }
    
    
    func addHabit(habit: Habit){//adds a task to the ViewModel
        print("in?")
        habitRepository.addHabit(habit)
        print("taskName: \(habit.habitName)")
        
        let habitVM = HabitCellViewModel(habit: habit)
        self.HabitCellViewModels.append(habitVM)
    }
    
    func updateHabit(habit: Habit){
        habitRepository.updateHabit(habit)
    }
    
    func deleteHabit(habit: Habit){
        habitRepository.delteHabit(habit)
        let habitVM = HabitCellViewModel(habit: habit)
        self.HabitCellViewModels.removeAll{$0.id==habitVM.id}
    }
    

}

