//
//  AddTaskTextView.swift
//  CoreDataToDo
//
//  Created by Michael  Murphy on 10/20/18.
//  Copyright © 2018 Michael  Murphy. All rights reserved.
//

import UIKit

class AddTaskTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTextView()
    }
    
    
    override func prepareForInterfaceBuilder() {
        setupTextView()
    }
    
    
    
    func setupTextView() {
        layer.cornerRadius = 5
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 14)
        font = UIFont.boldSystemFont(ofSize: 14)
    }

}
