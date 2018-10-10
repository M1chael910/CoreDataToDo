//
//  TaskCreatorVC.swift
//  To-Do
//
//  Created by Michael  Murphy on 9/2/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit

class TaskCreatorVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    //Variables
    
    var task: Task?
    
    
    
    
    
    //Constants
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let task = task {
            navigationItem.title = task.title
            displayInitialTaskProperties(from: task)
        }
    }
    
    func displayInitialTaskProperties(from task: Task) {
        titleTextField.text = task.title
        descriptionTextView.text = task.taskDescription
        datePicker.date = task.date!
        dueDatePicker.date = task.dueDate!
    }
    
    
    
    
    func saveProperties(task: Task) {
        if let title = titleTextField.text, let description = descriptionTextView.text {
            task.title = title
            task.taskDescription = description
        } else {
            task.title = "No Title"
            task.taskDescription = "No Description"
        }
        task.date = datePicker.date
        task.dueDate = dueDatePicker.date
    }

    
    
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
        updateNavItem(with: sender.text!)
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
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveBtn.isEnabled = !text.isEmpty
    }
    
    
    
    
    
  
}



