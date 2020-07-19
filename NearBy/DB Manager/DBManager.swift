//
//  DBManager.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation
import SQLite

class DBManager {
    
    private var database: Connection!
    
    private let venuTable = Table("venue")
    private let id = Expression<String>("id")
    private let name = Expression<String>("name")
    private let desc = Expression<String>("desc")
    
    init() {
        let isdbInit = UserDefaultManager.shared.get(for: .dbInit, defaultValue: false)
        if isdbInit {
            do {
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let database = try Connection("\(path)/db.sqlite3")
                self.database = database
            } catch {
                print(error)
            }
        } else {
            do {
                let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let fileUrl = documentDirectory.appendingPathComponent("db").appendingPathExtension("sqlite3")
                let database = try Connection(fileUrl.path)
                self.database = database
                
                self.createTables()
            } catch {
                print(error)
            }
        }
    }
    
    private func createTables() {
        let createVenuTable = self.venuTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.desc)
        }
        
        do {
            try self.database.run(createVenuTable)
            UserDefaultManager.shared.set(true, for: .dbInit)
            #if DEBUG
            print("VENUE TABLE CREATED")
            #endif
        } catch {
            print(error)
        }
    }
    
    func insertNewVenu(id: String, name: String, desc: String) {
        let insertVenu = self.venuTable.insert(self.id <- id, self.name <- name, self.desc <- desc)
        do {
            try self.database.run(insertVenu)
            #if DEBUG
            print("VENUE INSERTED")
            #endif
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
    }
    
    func getVenus() -> [VenueModel] {
        do {
            let venues = try self.database.prepare(self.venuTable)
            var models: [VenueModel] = []
            for item in venues {
                models.append(VenueModel(id: item[self.id], name: item[self.name], desc: item[self.desc]))
            }
            return models
        } catch {
            print(error)
            return []
        }
    }
}
