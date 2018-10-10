//
//  MainTaskCell.swift
//  To-Do
//
//  Created by Michael  Murphy on 9/3/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit


class MainTaskCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var taskTitleLbl: UILabel!
    
    func updateCell(task: Task) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateLbl.text = "\(dateFormatter.string(from: task.date!))"
        dueDateLbl.text = "\(dateFormatter.string(from: task.dueDate!))"
        taskTitleLbl.text = task.title
    }
}
