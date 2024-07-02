//
//  ViewController.swift
//  ToDoList
//
//  Created by Burak Özdemir on 2.07.2024.
//

import UIKit

class HomepageViewController: UIViewController 
{
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    let taskManager = TaskManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = taskManager.getGreetingMessage()
        
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        taskManager.uploadTasks()
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem)
    {
        performSegue(withIdentifier: "listToAdd", sender: self)
    }
    
}

extension HomepageViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int 
    {
        return taskManager.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell 
    {
        let task = taskManager.taskList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! ToDoCell
        
        if let safeTitle = task.task_title, let safeSubject = task.task_subject, let safeTime = task.task_time, let safeDuration = task.task_duration
        {
            cell.titleLabel.text = safeTitle
            cell.subjectLabel.text = safeSubject
            cell.timeLabel.text = safeTime
            cell.durationLabel.text = safeDuration
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
    {
        let task = taskManager.taskList[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "listToUpdate", sender: task)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) 
    {
        if segue.identifier == "listToUpdate"
        {
            if let task = sender as? ToDoTask
            {
                let updateVC = segue.destination as! UpdateViewController
                
                updateVC.heading = task.task_title
                updateVC.subject = task.task_subject
                updateVC.duration = task.task_duration
                updateVC.time = task.task_time
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? 
    {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){contextualAction, view, bool in
            _ = self.taskManager.taskList[indexPath.row]
            
            let alert = UIAlertController(title: "Delete Process", message: "Delete selected task ?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let acceptAction = UIAlertAction(title: "Accept", style: .destructive){action in
                
            }
            
            alert.addAction(cancelAction)
            alert.addAction(acceptAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
