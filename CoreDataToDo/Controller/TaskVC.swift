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
    
    @IBOutlet weak var taskListTableView: UITableView!
    @IBOutlet weak var taskLbl: UILabel!
    
    //Variables
    var tasks = [Task]()
    

    //Constants
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // [START setup]

        checkTasks()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        taskListTableView.reloadData()
    }
    
    @IBAction func completedTaskBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "CompletedTaskVC", sender: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        tasks.removeAll()
        taskListTableView.reloadData()
        checkTasks()
    }
    
    
    func getData() {
        do {
            tasks = try context.fetch(Task.fetchRequest())
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
        let mainTaskCell = tableView.dequeueReusableCell(withIdentifier: "MainTaskCell", for: indexPath) as! MainTaskCell
        
        if tasks.count > 0 {
            let task = tasks[indexPath.row]
            mainTaskCell.updateCell(task: task)
            return mainTaskCell
        } else {
            return MainTaskCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editTask", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "editTask":
            let taskEditorVC = segue.destination as? TaskCreatorVC
            let selectedTask = tasks[taskListTableView.indexPathForSelectedRow!.row]
            taskEditorVC?.task = selectedTask
        case "CompletedTaskVC":
            let completedTaskVC = segue.destination as? CompletedTaskVC
            for task in tasks {
                if task.isCompleted == true {
                    completedTaskVC?.completedTasks.append(task)
                }
            }
        default:
            print("nothing")
    }
    

}

}
