//
//  TaskCreatorVC.swift
//  To-Do
//
//  Created by Michael  Murphy on 9/2/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit



class TaskCreatorVC: UITableViewController, UITextViewDelegate {

    //Outlets
    
    
    @IBOutlet weak var titleTextView: AddTaskTextView!
    @IBOutlet weak var descriptionTextView: AddTaskTextView!
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var completedLbl: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    //Variables
    
    var task: Task?
    
    //Constants
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.hideKeyboardWhenTappedAround()
        if let task = task {
            navigationItem.title = task.title
            displayInitialTaskProperties(from: task)
            saveBtn.isEnabled = true
        } else {
            saveBtn.isEnabled = false
        }
    }
    
    
    
    func displayInitialTaskProperties(from task: Task) {
        titleTextView.text = task.title
        descriptionTextView.text = task.taskDescription
        datePicker.date = task.date!
        dueDatePicker.date = task.dueDate!
    }
    
    override func viewDidAppear(_ animated: Bool) {
       updateSaveButtonState()
    }
    
    func saveProperties(task: Task) {
        if let title = titleTextView.text, let description = descriptionTextView.text {
            task.title = title
            task.taskDescription = description
        } else {
            task.title = "No Title"
            task.taskDescription = "No Description"
        }
        task.date = datePicker.date ?? Date()
        task.dueDate = dueDatePicker.date ?? Date()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
        if let text = textView.text {
            if text == "" {
                updateNavItem(with: "Enter a task")
            } else {
                updateNavItem(with: text)
            }
        }
    }
    
    @IBAction func completedSwitchPressed(_ sender: UISwitch) {
        if sender.isOn == true {
            completedLbl.text = "On To the Next Task!"
        } else {
            completedLbl.text = "Get To Work!"
        }
    }
    
    func updateNavItem(with text: String) {
        self.navigationItem.title = text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if segue.identifier == "saveBtnPressed" {
            if let destination = segue.destination as? TaskVC {
                if let task = task {
                    saveProperties(task: task)
                    appDelegate.saveContext()
                } else {
                    let newTask = Task(context: context)
                    saveProperties(task: newTask)
                    destination.tasks.append(newTask)
                    appDelegate.saveContext()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = tableView.visibleCells[indexPath.row]
        row.isHighlighted = false
        row.isSelected = false
    }
    
        func updateSaveButtonState() {
            if titleTextView.text?.isEmpty == true {
                saveBtn.isEnabled = false
            } else {
                saveBtn.isEnabled = true
            }
    }
    
    
    
    
    
  
}



