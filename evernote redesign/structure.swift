//
//  structure.swift
//  evernote redesign
//
//  Created by Valeed Abdul Hameed on 22/11/22.
//

import Foundation

struct Card : Identifiable, Codable {
    init(title: String, description : String){
        self.id = UUID()
        self.title = title
        self.description = description
        self.isFavorited = false
        //self.timestamp = DispatchTime.now()
    }
    init(){
        self.id = UUID()
        self.title = ""
        self.description = ""
        self.isFavorited = false
        //self.timestamp = DispatchTime.now()
    }

//    mutating func updateTimestamp(){
//        timestamp = DispatchTime.now()
//    }
    
    var id = UUID()
    var title : String
    var description : String
    var isFavorited : Bool
    //var timestamp : DispatchTime
    
}
