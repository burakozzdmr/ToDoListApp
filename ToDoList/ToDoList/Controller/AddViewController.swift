//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Burak Özdemir on 2.07.2024.
//

import UIKit

class AddViewController: UIViewController 
{

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    let taskManager = TaskManager()
    let homepageVC = HomepageViewController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "Geri", style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func goBack() 
    {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addPressed(_ sender: UIButton) 
    {
        if let safeTitle = titleTextField.text, let safeSubject = subjectTextField.text, let safeDuration = durationTextField.text, let safeTime = timeTextField.text
        {
            taskManager.save(task_title: safeTitle, task_subject: safeSubject, task_duration: safeDuration, task_time: safeTime)
        }
    }
}
