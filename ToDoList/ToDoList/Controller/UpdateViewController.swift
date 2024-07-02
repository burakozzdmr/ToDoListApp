//
//  UpdateViewController.swift
//  ToDoList
//
//  Created by Burak Özdemir on 2.07.2024.
//

import UIKit

class UpdateViewController: UIViewController 
{

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    var heading: String?
    var subject: String?
    var duration: String?
    var time: String?
    
    let taskManager = TaskManager()
    var homepageVC = HomepageViewController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let safeHeading = heading, let safeSubject = subject, let safeDuration = duration, let safeTime = time
        {
            titleTextField.text = safeHeading
            subjectTextField.text = safeSubject
            durationTextField.text = safeDuration
            timeTextField.text = safeTime
        }
        
    }

    @IBAction func updatePressed(_ sender: UIButton)
    {
        if let safeTitle = titleTextField.text, let safeSubject = subjectTextField.text, let safeDuration = durationTextField.text, let safeTime = timeTextField.text
        {
            taskManager.update(task_id: 1, task_title: safeTitle, task_subject: safeSubject, task_duration: safeDuration, task_time: safeTime)
        }
    }
    
}
