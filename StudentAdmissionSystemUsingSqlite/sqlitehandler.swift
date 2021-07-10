//
//  sqlitehandler.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 09/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3

class sqlitehandler {
    
    let path = "studentDB.sqlite"
    
    static let shared = sqlitehandler()
    
    
    
    var db : OpaquePointer?
    
    private init(){
        db = openDB()
        createTbl()
    }
    
    func openDB() -> OpaquePointer?
    {
        let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileUrl = docUrl.appendingPathComponent(path)
        
        var databse:OpaquePointer? = nil
        
        
        
        if sqlite3_open (fileUrl.path, &databse) == SQLITE_OK
        {
            print("connection open : \(fileUrl)")
            return databse
            
        }
        else{
            
            print("error while open connection....")
            return nil
        }
    }
    
    func createTbl(){
        
        let createtblStr = """
        
CREATE TABLE IF NOT EXISTS student(
spid STRING PRIMARY KEY,
studName STRING,
city STRING,
phoneno STRING,
standard STRING,
age INTEGER
);
"""
        
        var createtblstmnt : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createtblStr, -1, &createtblstmnt, nil) == SQLITE_OK
        {
            if sqlite3_step(createtblstmnt ) == SQLITE_DONE
            {
                    print("create table student")
                
            }
            else{
                
                
                print("table not created")
            }
            
            
        }
        else
        {
            
            
            print("table staement note prepared...")
        }
        sqlite3_reset(createtblstmnt)
    }
    
    func insert(stud: student, completion : @escaping(Bool)->Void){
        
        let insertstr = "INSERT INTO student (spid, studname, city, phoneno, standard, age) VALUES (?,?,?,?,?,?);"
        
        var insertstmnt: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertstr, -1, &insertstmnt, nil) == SQLITE_OK
        {
            //binding
            
            sqlite3_bind_text(insertstmnt, 1, (stud.spid as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertstmnt, 2, (stud.studName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertstmnt, 3, (stud.city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertstmnt, 4, (stud.standard as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertstmnt, 5, (stud.phoneno as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertstmnt, 6, Int32(stud.age))
            
            
            if sqlite3_step(insertstmnt ) == SQLITE_DONE
            {
                print("insert student")
                completion(true)
            }
            else{
                
                completion(false)
                print("insert not done")
            }
            
            
        }
        else
        {
            completion(false)
            
            print("insert staement note prepared...")
        }
        sqlite3_reset(insertstmnt)
    }
    
    func fetch()->[student]{
        let fetchstr = "SELECT * FROM student;"
        var fetchstmnt : OpaquePointer? = nil
        var stud = [student]()
         if sqlite3_prepare_v2(db, fetchstr, -1, &fetchstmnt, nil) == SQLITE_OK

         {
            while sqlite3_step(fetchstmnt) == SQLITE_ROW
            {
                let id = String(cString: sqlite3_column_text(fetchstmnt, 0))
                let name = String(cString: sqlite3_column_text(fetchstmnt, 1))
                let city = String(cString: sqlite3_column_text(fetchstmnt, 2))
                let phone = String(cString: sqlite3_column_text(fetchstmnt, 3))
                let std = String(cString: sqlite3_column_text(fetchstmnt, 4))
                let age = Int(sqlite3_column_int(fetchstmnt, 5))
                
                stud.append(student(id: id, name: name, city: city, phone: phone, std: std, age: age))
                
                print("\(id)")
                
                
            }
            
        }
         else{
            
            print("fetch statement not prepared")
        }
        sqlite3_finalize(fetchstmnt)
        return stud
        
    }
    
    func update (stud : student, completion : @escaping(Bool)->Void)
    
    {
        
        let updatestr = "UPDATE student SET studName = ? ,  city = ? , standard = ?, phoneno = ? ,age = ?  WHERE spid = ?;"
        
        var updatestmnt : OpaquePointer? = nil
        
        // prepare
        if sqlite3_prepare_v2(db,updatestr, -1, &updatestmnt, nil) == SQLITE_OK
        {
            //binding
            
           
            sqlite3_bind_text(updatestmnt, 1, (stud.studName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatestmnt, 2, (stud.city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatestmnt, 3, (stud.standard as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updatestmnt, 4, (stud.phoneno as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updatestmnt, 5, Int32(stud.age))
            
            
            if sqlite3_step(updatestmnt ) == SQLITE_DONE
            {
                print("upadte student")
                completion(true)
            }
            else{
                
                completion(false)
                print("update not done")
            }
            
            
        }
        else
        {
            completion(false)
            
            print("update staement note prepared...")
        }
        sqlite3_reset(updatestmnt)
    }
    
    func delete (for id : String, completion : @escaping(Bool)->Void){
        
        let delstr = "DELETE FROM student WHERE spid = ?;"
        
        var delstmnt: OpaquePointer?
        
        if sqlite3_prepare_v2(db,delstr, -1, &delstmnt, nil) == SQLITE_OK
        {
            //binding
            
            
            sqlite3_bind_text(delstmnt, 1, (id as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(delstmnt ) == SQLITE_DONE
            {
                completion(true)
                print("delete student")
                
            }
            else{
                
                completion(false)
                print("delete not done")
            }
            
            
        }
        else
        {
            
            completion(false)
            print("delete staement note prepared...")
        }
        sqlite3_reset(delstmnt)
    }
}

