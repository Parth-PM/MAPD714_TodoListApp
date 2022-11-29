//
//  ViewController.swift
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todoList = [ToDoList]()
    
    @IBOutlet weak var ToDoTableView: UITableView!
    
    var firstLoad = true
    var selectedTodo: ToDoList? = nil
    
    // Function for non deleted todos
        
    func nonDeletedTodos() -> [ToDoList]
    {
        var noDeleteTodoList = [ToDoList]()
        for todo in todoList
        {
            if(todo.deletedDate == nil)
            {
                noDeleteTodoList.append(todo)
            }
        }
        return noDeleteTodoList
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ToDoTableView.delegate = self
        ToDoTableView.dataSource = self
        ToDoTableView.rowHeight = 69
        
        // On loading the ViewController for the first time
        
        if(firstLoad)
                {
                    firstLoad = false
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
                    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
                    do {
                        let results:NSArray = try context.fetch(request) as NSArray
                        for result in results
                        {
                            let todo = result as! ToDoList
                            todoList.append(todo)
                        }
                    }
                    catch
                    {
                        print("Fetch Failed")
                    }
                }
        
    }
    
    // Function for number of rows in table view
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedTodos().count
    }
    
    // Function for implementing cells of table view
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrototypeCell") as! TableCell
        
        let thisTodo: ToDoList!
        thisTodo = nonDeletedTodos()[indexPath.row]
                 
        cell.todoName.text = thisTodo.name
        cell.todoStatus.text = thisTodo.desc
        cell.editButton.tag = indexPath.row
        
        return cell
    
    }
    
    override func viewDidAppear(_ animated: Bool)
        {
            ToDoTableView.reloadData()
        }

    }




