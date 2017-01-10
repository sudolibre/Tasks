//
//  TaskStore.swift
//  Tasks
//
//  Created by Jonathon Day on 1/10/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

class TaskStore {
    private(set) var tasks = [Task]()
    
    internal func addTask(_ task: Task) {
        tasks.append(task)
    }
    
    internal func updateTask(_ task: Task, withDescription title: String) {
        if let taskToUpdate = tasks.first(where: { $0.title == task.title }) {
            taskToUpdate.title = title
        } else {
            print("No task found with title \(task.title) to update")
        }
    }
    
    internal func deleteTask(_ task: Task) {
        if let taskToUpdateIndex = tasks.index(where: { $0.title == task.title }) {
            tasks.remove(at: taskToUpdateIndex)
        } else {
            print("No task found with title \(task.title) to delete")
        }
    }
    
    internal func moveItem(from fromIndex: Int, to toIndex: Int) {
        guard fromIndex != toIndex, tasks.indices.contains(fromIndex), tasks.indices.contains(toIndex) else {
            return
        }
        
        let movingItem = tasks[fromIndex]
        tasks.remove(at: fromIndex)
        tasks.insert(movingItem, at: toIndex)
        
    }

}
