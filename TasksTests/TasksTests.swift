//
//  TasksTests.swift
//  TasksTests
//
//  Created by Jonathon Day on 1/10/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import XCTest
@testable import Tasks

class TasksTests: XCTestCase {
    
    func testAddTask() {
        let taskStore = TaskStore()
        taskStore.addTask(Task(title: "firstTask"))
        taskStore.addTask(Task(title: "secondTask"))
        taskStore.addTask(Task(title: "thirdTask"))
        XCTAssertTrue(taskStore.tasks.first!.title == "firstTask")
        XCTAssertTrue(taskStore.tasks[1].title == "secondTask")
        XCTAssertTrue(taskStore.tasks.last!.title == "thirdTask")
        
        
    }
    
    func testUpdateTask() {
        let taskStore = TaskStore()
        taskStore.addTask(Task(title: "firstTask"))
        taskStore.addTask(Task(title: "secondTask"))
        taskStore.addTask(Task(title: "thirdTask"))
        taskStore.updateTask(taskStore.tasks.first!, withDescription: "updatedFirst")
        XCTAssertTrue(taskStore.tasks.first!.title == "updatedFirst")
    }
    
    func testDeleteTask() {
        let taskStore = TaskStore()
        taskStore.addTask(Task(title: "firstTask"))
        taskStore.addTask(Task(title: "secondTask"))
        taskStore.addTask(Task(title: "thirdTask"))
        taskStore.deleteTask(taskStore.tasks[1])
        XCTAssertTrue(taskStore.tasks[1].title == "thirdTask")
    }
    
    func testMoveTask() {
        let taskStore = TaskStore()
        taskStore.addTask(Task(title: "firstTask"))
        taskStore.addTask(Task(title: "secondTask"))
        taskStore.addTask(Task(title: "thirdTask"))
        taskStore.moveItem(from: 2, to: 1)
        taskStore.moveItem(from: 0, to: 2)
        XCTAssertTrue(taskStore.tasks.map({$0.title}) == ["thirdTask", "secondTask", "firstTask"])
    }
    
}
