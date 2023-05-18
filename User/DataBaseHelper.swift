//
//  DataBaseHelper.swift
//  User
//
//  Created by pratiksha jagtap on 5/17/23.
//

import Foundation
import Foundation
import UIKit
import CoreData

class DataBaseHandler{
    var context = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
    
    func saveData(first_name:String, last_name:String, email:String,id:Int64,avatar:String){
        let UserDataObject = NSEntityDescription.insertNewObject(forEntityName: "UserModel", into: context) as! UserModel
        UserDataObject.first_name = first_name
        UserDataObject.last_name = last_name
        UserDataObject.email = email
        UserDataObject.id = id
        UserDataObject.avatar = avatar
        do{
            try context.save()
            print("student Data Sucessfully saved")
        }
        catch{
            print("student Data Saving Error")
        }
    }
    func fetchData()->[UserModel]{
        var data=[UserModel]()
        
        do{
            data = try context.fetch(UserModel.fetchRequest()) as! [UserModel]
            print("Data sucessfully fetched")
        }
        catch{
            print("error occured during Fetching data")
        }
        return data
    }
    func updateStudentRecord(oldObject:UserModel,first_name:String, last_name:String, email:String,id:Int64,avatar:String){
         oldObject.first_name = first_name
         oldObject.last_name = last_name
         oldObject.email = email
         oldObject.id = id
        oldObject.avatar = avatar
         do{
             try context.save()
         }catch{}
     }
}
