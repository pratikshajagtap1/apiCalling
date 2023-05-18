//
//  UserModel+CoreDataProperties.swift
//  
//
//  Created by pratiksha jagtap on 5/17/23.
//
//

import Foundation
import CoreData


extension UserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "UserModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var email: String?
    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var avatar: String?

}
