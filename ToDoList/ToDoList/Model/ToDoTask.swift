//
//  ToDoTask.swift
//  ToDoList
//
//  Created by Burak Özdemir on 2.07.2024.
//

import Foundation

class ToDoTask
{
    let task_title: String?
    let task_subject: String?
    let task_time: String?
    let task_duration: String?
    
    
    init(task_title: String, task_subject: String, task_time: String, task_duration: String)
    {
        self.task_title = task_title
        self.task_subject = task_subject
        self.task_time = task_time
        self.task_duration = task_duration
    }
    
}
