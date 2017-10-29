//
//  Memo+CoreDataProperties.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/05.
//  Copyright © 2017年 mirai. All rights reserved.
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var memo: String?

}
