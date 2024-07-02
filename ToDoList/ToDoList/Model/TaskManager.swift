//
//  TaskManager.swift
//  ToDoList
//
//  Created by Burak Özdemir on 2.07.2024.
//

import Foundation

class TaskManager
{
    
    let db: FMDatabase?
    
    init()
    {
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: targetPath).appendingPathComponent("TODOLIST.sqlite")
        
        db = FMDatabase(path: databaseURL.path)
        
        copyDatabase()
    }
    
    func copyDatabase()
    {
        let bundlePath = Bundle.main.path(forResource: "TODOLIST", ofType: ".sqlite")
        let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let copyPlace = URL(fileURLWithPath: targetPath).appendingPathComponent("TODOLIST.sqlite")
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: copyPlace.path)
        {
            print("Database already exists.")
        }
        else
        {
            do
            {
                try fileManager.copyItem(atPath: bundlePath!, toPath: copyPlace.path)
            }
            catch
            {
                
            }
        }
    }
    
    let taskList: [ToDoTask] =
    [
        ToDoTask(task_title: "Breakfast", task_subject: "eat healthly foods ", task_time: "09:00", task_duration: "30 minutes"),
        ToDoTask(task_title: "Work", task_subject: "Software ", task_time: "10:00", task_duration: "240 minutes"),
        ToDoTask(task_title: "Lunch", task_subject: "chicken saute and orange juice", task_time: "14:30", task_duration: "30 minutes"),
        ToDoTask(task_title: "Sport", task_subject: "Fitness", task_time: "16:00", task_duration: "90 minutes"),
        ToDoTask(task_title: "Dinner", task_subject: "beef and some wine", task_time: "18:00", task_duration: "30 minutes")
    ]
    
    func getGreetingMessage() -> String
    {
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        
        switch hour
        {
        case 8..<12:
            return "Good Morning 👋🏻"
        case 12..<18:
            return "Have a Nice Day 👋🏻"
        case 18..<24:
            return "Good Afternoon 👋🏻"
        default:
            return "Good Night 👋🏻"
        }
    }
    
    func save(task_title: String, task_subject: String, task_duration: String, task_time: String)
    {
        db?.open()
        
        do
        {
            let result = try db?.executeUpdate("INSERT INTO TODOLIST(task_title, task_subject, task_duration, task_time) VALUES(?, ?, ?, ?)",
                                               values: [task_title, task_subject, task_duration, task_time])
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(task_id: Int, task_title: String, task_subject: String, task_duration: String, task_time: String)
    {
        db?.open()
        
        do
        {
            let result = try db?.executeUpdate("UPDATE TODOLIST SET task_title = ?, task_subject = ?, task_duration = ?, task_time = ?, WHERE task_id = ?",
                                               values: [task_title, task_subject, task_duration, task_time, task_id])
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func remove(task_id: Int)
    {
        db?.open()
        
        do
        {
            let result = try db?.executeUpdate("DELETE FROM TODOLIST WHERE task_id = ?", values: [task_id])
            uploadTasks()
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func uploadTasks()
    {
        db?.open()
        var taskList = [ToDoTask]()
        
        do
        {
            let result = try db!.executeQuery("SELECT * FROM TODOLIST", values: nil)
            
            while result.next()
            {
                let task = ToDoTask(task_title: result.string(forColumn: "task_title"),
                                    task_subject: result.string(forColumn: "task_subject"),
                                    task_time: result.string(forColumn: "task_time"),
                                    task_duration: result.string(forColumn: "task_duration"))
                
                taskList.append(task)
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
