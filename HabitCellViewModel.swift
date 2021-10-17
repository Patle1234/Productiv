//
//  HabitCellViewModel.swift
//  Productiv
//
//  Created by Dev Patel on 10/14/21.
//


import Foundation
import Combine

class HabitCellViewModel: ObservableObject, Identifiable{
    @Published var habitRepo=HabitRepository()
    @Published var habit: Habit
    var id:String = ""
    private var cancellable = Set<AnyCancellable>()
    var ifCompletedIcon: String = ""
    
    init(habit: Habit){
        self.habit=habit
        $habit
            .map{habit in
                habit.ifCompleted ? "app.fill" : "sqaure"
            }
            .assign(to: \.ifCompletedIcon, on: self)
            .store(in: &cancellable)
        $habit
            .compactMap{habit in
                habit.id
            }
        .assign(to: \.id, on: self)
        .store(in: &cancellable)
        
        $habit
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)//only sends to Firestore every .8 secs
            .sink{habit in
                self.habitRepo.updateHabit(habit)
            }
            .store(in: &cancellable)
        
        print("created")
        
    }
    static func newHabit() -> HabitCellViewModel {
        HabitCellViewModel(habit: Habit(habitName: " ",ifCompleted: false,plus:0,minus:0))
    }
}
