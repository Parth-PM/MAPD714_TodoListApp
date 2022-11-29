//
//  ToDoList+CoreDataProperties.swift
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
//

import Foundation
import CoreData


extension ToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoList> {
        return NSFetchRequest<ToDoList>(entityName: "ToDoList")
    }

    @NSManaged public var name: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var notes: String?
    @NSManaged public var hasDuedate: Bool
    @NSManaged public var desc: String?
    @NSManaged public var deletedDate: Date?


}

extension ToDoList : Identifiable {

}
