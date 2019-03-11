//
//  CoreDataContainer.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 3/11/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataContainer {
    func saveCurrentLevel(id: Int, level: Int) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Quiz")
        fetchRequest.predicate = NSPredicate(format: "rhymeId = %@", String(id))
        do {
            if let quiz = try managedContext.fetch(fetchRequest).first {
                quiz.setValue(level, forKeyPath: "question")
                print("Updating \(id)")
                try managedContext.save()
            } else {
                let entity = NSEntityDescription.entity(forEntityName: "Quiz",
                                                        in: managedContext)!
                let quiz = NSManagedObject(entity: entity,
                                           insertInto: managedContext)
                quiz.setValue(id, forKeyPath: "rhymeId")
                quiz.setValue(level, forKeyPath: "question")
                try managedContext.save()
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getCurrentLevel(id: String) -> Int? {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Quiz")
        let predicate = NSPredicate(format: "rhymeId = %@", String(id))
        fetchRequest.predicate = predicate
        do {
            let currentLevel = try managedContext.fetch(fetchRequest).first?.value(forKeyPath: "question")
            print("CurrentLevel: \(currentLevel ?? "--")")
            return currentLevel as? Int
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
}
