//
//  DetailsViewController.swift
//  ToDoList_Assignment5
//
//  Student Name: Deep Mehta
//  Student id: 301212407
//  Student Name: Khushboo Kodwani
//  Student id: 301273818
//  Student Name: Parth Maru
//  Student id: 301209761
//
//  Date: 27 November 2022
//  App name: TodoList
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    @IBOutlet weak var todoName: UITextField!
    @IBOutlet weak var todoDesc: UITextField!
    @IBOutlet weak var dateTime: UIDatePicker!
    
    @IBOutlet weak var dueDateSwitch: UISwitch!
    
    @IBOutlet weak var completedSwitch: UISwitch!
    
    var selectedTodo: ToDoList? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(selectedTodo != nil)
        {
            todoName.text = selectedTodo?.name
            todoDesc.text = selectedTodo?.desc
        }
    }
    
    // On clicking due date switch control
    
    @IBAction func dueDateSwitchTap(_ sender: UISwitch) {
    
        if(dueDateSwitch.isOn){
            dateTime.isHidden = false
        }
        else {
            dateTime.isHidden = true
        }
        
    }
    
    // On clicking update button

    @IBAction func updateTap(_ sender: UIButton)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if(selectedTodo == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Todo", in: context)
            let newTodo = ToDoList(entity: entity!, insertInto: context)
            newTodo.id = String(todoList.count)
            newTodo.name = todoName.text
            newTodo.desc = todoDesc.text
            do
            {
                try context.save()
                todoList.append(newTodo)
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("context save error")
            }
        }
        else
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let todo = result as! ToDoList
                    if(todo == selectedTodo)
                    {
                        todo.name = todoName.text
                        todo.desc = todoDesc.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
        }
    }
    
    // On clicking cancel button
    
    @IBAction func cancelTap(_ sender: UIButton) {
        todoName.text = ""
        todoDesc.text = ""
        dueDateSwitch.setOn(true, animated: true)
        completedSwitch.setOn(false, animated: true)
    }
    
    // On clicking delete button
    
    @IBAction func deleteTap(_ sender: UIButton)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let todo = result as! ToDoList
                if(todo == selectedTodo)
                {
                    todo.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
    


}
