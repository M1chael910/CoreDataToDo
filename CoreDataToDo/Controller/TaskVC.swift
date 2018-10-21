//
//  ViewController.swift
//  To-Do
//
//  Created by Michael  Murphy on 9/2/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit


class TaskVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Outlets
    
    @IBOutlet weak var editBtn: UIBarButtonItem!
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var taskLbl: UILabel!
    
    //Variables
    
    var tasks: [Task] = []
    
    //Constants
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkEditBtnStatus()
        getData()
        checkTasks()
        navigationController?.navigationBar.prefersLargeTitles = true
        // [START setup]
        checkTasks()
    }
    
    @IBAction func editBtnPresed(_ sender: UIBarButtonItem) {
        if sender.tag == 0 {
            taskListTableView.isEditing = true
            sender.tag = 1
        } else {
            taskListTableView.isEditing = false
            sender.tag = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkEditBtnStatus()
        checkTasks()
        getData()
        taskListTableView.reloadData()
    }
    
    @IBAction func completedTaskBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "CompletedTaskVC", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
    }


    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let removedTask = tasks[indexPath.row]
            tasks.remove(at: indexPath.row)
            context.delete(removedTask)
            taskListTableView.reloadData()
            checkTasks()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        checkEditBtnStatus()
        checkTasks()
        taskListTableView.reloadData()
    }
    
    func checkTasks() {
        if tasks.count > 0 {
            taskListTableView.isHidden = false
            taskLbl.isHidden = true
        } else {
            taskListTableView.isHidden = true
            taskLbl.isHidden = false
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func clearTasks() {
        deleteData()
        tasks.removeAll()
        taskListTableView.reloadData()
        checkTasks()
    }
    
    
    func getData() {
        do {
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch {
            print("data not recieved")
        }
        taskListTableView.reloadData()
    }
    
    func deleteData() {
        do {
            for task in tasks {
                context.delete(task)
            }
        }
        catch {
            
        }
        taskListTableView.reloadData()
    }
    
    @IBAction func clearTaskBtnPressed(_ sender: UIButton) {
        clearTasks()
    }

    @IBAction func unwindToTaskList(segue: UIStoryboardSegue) {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mainCell = taskListTableView.dequeueReusableCell(withIdentifier: "MainTaskCell", for: indexPath) as! MainTaskCell
        if tasks.count > 0 {
            let task = tasks[indexPath.row]
            mainCell.updateCell(with: task)
            return mainCell
        } else {
            return MainTaskCell()
        }
    }
    
    func checkEditBtnStatus() {
        if tasks.isEmpty == true {
            editBtn.isEnabled = false
        } else {
            editBtn.isEnabled = true
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editTask", sender: nil)
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "editTask":
            let taskEditorVC = segue.destination as! TaskCreatorVC
            let selectedTask = tasks[taskListTableView.indexPathForSelectedRow!.row]
            taskEditorVC.task = selectedTask
        case "CompletedTaskVC":
            let completedTaskVC = segue.destination as? CompletedTaskVC
            for task in tasks {
                if task.isCompleted == true {
                    completedTaskVC?.completedTasks.append(task)
                }
            }
        default:
            print("")
    }
}

}
