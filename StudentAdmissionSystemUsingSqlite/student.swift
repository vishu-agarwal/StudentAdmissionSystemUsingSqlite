//
//  student.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 09/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class student{
    
    var spid : String = ""
    var studName : String = ""
    var phoneno : String = ""
    var age: Int = 0
    var password : String = ""
    var standard : String = ""
    init(id:String ,name:String,password:String, phone: String, std: String , age:Int)
    {
        self.spid = id
        self.studName = name
        self.password = password
        self.phoneno = phone
        self.standard = std
        self.age = age
        
    }
    
    
}
