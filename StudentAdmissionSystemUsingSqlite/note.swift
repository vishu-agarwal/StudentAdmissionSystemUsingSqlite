
//
//  note.swift
//  StudentAdmissionSystemUsingSqlite
//
//  Created by DCS on 12/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class note {
    var nid : Int = 0
    var ntitle : String = ""
    var msg : String = ""
    
    init(nid:Int,ntitle:String,msg:String) {
        
        self.nid = nid
        self.msg = msg
        self.ntitle = ntitle
        
    }
}
