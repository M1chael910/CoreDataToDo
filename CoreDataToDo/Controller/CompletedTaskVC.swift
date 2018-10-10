//
//  CreatedTaskVC.swift
//  To-Do
//
//  Created by Michael  Murphy on 9/26/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit


class CompletedTaskVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var completedTaskTableView: UITableView!
    @IBOutlet weak var completedTaskLbl: UILabel!
    
    //Variables
    var completedTasks: [Task] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkCompletedTask()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        completedTaskTableView.reloadData()
        checkCompletedTask()
    }
    
    func checkCompletedTask() {
        if completedTasks.count > 0 {
            completedTaskTableView.isHidden = false
            completedTaskLbl.isHidden = true
        } else {
            completedTaskTableView.isHidden = true
            completedTaskLbl.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completedTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let completedTaskCell = tableView.dequeueReusableCell(withIdentifier: "MainTaskCell", for: indexPath) as! MainTaskCell
        for task in completedTasks {
            completedTaskCell.updateCell(task: task)
        }
        return completedTaskCell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
