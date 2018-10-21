//
//  MainTaskCell.swift
//  To-Do
//
//  Created by Michael  Murphy on 9/3/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit


class MainTaskCell: UITableViewCell {

    @IBOutlet weak var taskTitleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    
    
    func updateCell(with task: Task) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateLbl.text = "\(dateFormatter.string(from: task.date ?? Date()))"
        dueDateLbl.text = "\(dateFormatter.string(from: task.dueDate ?? Date()))"
        taskTitleLbl.text = task.title
    }
}
