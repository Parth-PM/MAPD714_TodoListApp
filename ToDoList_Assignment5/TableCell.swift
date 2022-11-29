//
//  TableCell.swift
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

class TableCell: UITableViewCell {

    @IBOutlet weak var todoName: UILabel!
    
    @IBOutlet weak var todoStatus: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var selectedTodo: ToDoList? = nil
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func mySwitchTap(_ sender: UISwitch) {
        // Getting UISwitch current status
        let switchStatus:Bool = sender.isOn
        
        if(switchStatus){
            mySwitch.setOn(false, animated: true)
        }
        else{
            mySwitch.setOn(true, animated: true)
        }

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
            do {
                let navigationController = self.window?.rootViewController as! UINavigationController
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results
                {
                    let todo = result as! ToDoList
                    if(todo == selectedTodo)
                    {
                        todo.deletedDate = Date()
                        try context.save()
                        navigationController.popViewController(animated: true)
                    }
                }
            }
            catch
            {
                print("Fetch Failed")
            }
    }
    

}
