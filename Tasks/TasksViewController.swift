//
//  ViewController.swift
//  Tasks
//
//  Created by Jonathon Day on 1/10/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

class TasksViewController: UITableViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    var taskStore: TaskStore!
    

    func updateItem(_ sender: UILongPressGestureRecognizer) {
        print("Long press detected")
        
       
        
        let touchLocation = sender.location(in: self.view)
        if let indexPath = tableView.indexPathForRow(at: touchLocation) {
            let task = taskStore.tasks[indexPath.row]
            var updateAlertController: UIAlertController {
                let ac = UIAlertController(title: "Update Task", message: nil, preferredStyle: .alert)
                let updateAction = UIAlertAction(title: "Update", style: .default) {
                    if let description = ac.textFields?.first?.text {
                        self.taskStore.updateTask(task, withDescription: description)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("\($0) Item updated")
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {print("\($0) Cancelled")})
                ac.addAction(updateAction)
                ac.addAction(cancelAction)
                ac.addTextField {
                    $0.placeholder = "Enter new task description"
                    $0.delegate = self
                }
                return ac
            }
            present(updateAlertController, animated: true)
        }
        

    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        var addAlertController: UIAlertController {
            let ac = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
            let addAction = UIAlertAction(title: "Add", style: .default) {
                if let description = ac.textFields?.first?.text {
                    self.taskStore.addTask(Task(title: description))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print("\($0) Item added")
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {print("\($0) Cancelled")})
            ac.addAction(addAction)
            ac.addAction(cancelAction)
            ac.addTextField {
                $0.placeholder = "Enter task description"
                $0.delegate = self
            }
            return ac
        }
        
        present(addAlertController, animated: true)
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        } else {
            self.setEditing(true, animated: true)
            sender.setTitle("Done", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(updateItem))
        longPressRecognizer.delegate = self
        self.tableView.addGestureRecognizer(longPressRecognizer)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "taskCell")
        cell.textLabel?.text = taskStore.tasks[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.tasks.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let task = taskStore.tasks[indexPath.row]
            taskStore.deleteTask(task)
        }
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        taskStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {
            return
        }
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

