//
//  MultiListManager.swift
//  GroceryList
//
//  Created by Keillor Jennings on 5/29/24.
//

import Foundation
import SwiftUI
import OrderedCollections
//import Collections

class MultiListManager : ObservableObject, Identifiable {
    //filenames of the individual lists should be a UUID
    
    @Published var allLists : OrderedDictionary<UUID, String> //dictionary with list title as the key and the UUID as the value.
    var fileURL : URL //file URL of the index file
    
    init() {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = directory.appendingPathComponent("index").appendingPathExtension("plist")
        let propertyListDecoder = PropertyListDecoder()
        if let fetchedData = try? Data(contentsOf: self.fileURL),
           let decodedData = try? propertyListDecoder.decode(OrderedDictionary<UUID, String>.self, from: fetchedData) {
            self.allLists = decodedData
        } else {
            self.allLists = [:]
        }
    }
    
    func load() {
        // Loads in the index file (with all of the lists UUIDs)
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = directory.appendingPathComponent("index").appendingPathExtension("plist")
        let propertyListDecoder = PropertyListDecoder()
        if let fetchedData = try? Data(contentsOf: self.fileURL),
           let decodedData = try? propertyListDecoder.decode(OrderedDictionary<UUID, String>.self, from: fetchedData) {
            self.allLists = decodedData
        } else {
            self.allLists = [:]
        }
    }
    
    func save() {
        // Saves the list of UUIDs
        let propertyListEncoder = PropertyListEncoder()
        if let encodedData = try? propertyListEncoder.encode(self.allLists) {
            try? encodedData.write(to: self.fileURL, options: .noFileProtection)
        }
    }
    
    func createNewList(name listTitle : String, _ id : UUID = UUID()) -> UUID {
        // creates a new list based on title provided.
        // UUID is the key, hence lists can have the same title
        // Providing UUID is optional
        // returns: UUID
        self.allLists[id] = listTitle
        self.save()
        return id
    }
    
    func Refresh() {
        //creates a copy of the list and saves it to itself 
        // (helpful when we cannot create a binding)
        let copy_list = self.allLists
        self.allLists = copy_list
    }
    
    func RemoveAll() {
        //removes all lists from multimanager.
        
        /* //less efficient version of this, but code is cleaner
        for list in self.allLists {
            self.DeleteList(list.key)
        }*/
        for list in self.allLists {
            self.DeleteFile(id: list.key)
        }
        self.allLists.removeAll()
        self.save()
    }
    
    func RenameList(key: UUID, newTitle: String) {
        if(!newTitle.isEmpty) {
            self.allLists[key] = newTitle
        }
        self.save()
        return
    }
    
    func DeleteFile(id: UUID) {
        // Deletes the file of the selected UUID.
        // Catches its own error if file DNE.
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileurl = directory.appendingPathComponent(id.uuidString).appendingPathExtension("plist")
        
        let fileManager = FileManager.default
        do {
            print(fileurl)
            try fileManager.removeItem(at: fileurl)
        } catch {
            print("Could not delete file: \(error.localizedDescription)")
        }
    }
    
    func DeleteList(_ indexSet: IndexSet) {
        //for general use with .onDelete overloads inside of list and other generative views
        for index in indexSet {
            let keyToDelete = self.allLists.keys.sorted(by: { $0.uuidString < $1.uuidString })[index]
            self.allLists.removeValue(forKey: keyToDelete)
            self.DeleteFile(id: keyToDelete)
        }
        self.save()
    }
    
    func DeleteList(_ key: UUID) {
        //for general use when the key of the key/value pair is avalible in the context
        self.allLists.removeValue(forKey: key)
        self.DeleteFile(id: key)
        self.save()
    }
    
    func ChangeListTitle(_ key: UUID, _ newTitle: String) {
        if(!newTitle.isEmpty) {
            self.allLists[key] = newTitle
        }
        
    }
}
