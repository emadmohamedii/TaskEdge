//
//  RealmHelper.swift
//
//
//  Created by Emad Habib on 15/07/2024.
//

import Foundation
import RealmSwift
import NetworkKit

public final class RealmHelper {
    
    let realm = try! Realm()
    
    public init() {}
    
    public func addUniversities(_ universities: [University]) {
        try! realm.write {
            realm.add(universities)
        }
    }
    
    public func getAllUniversities() -> [UniversityResponse] {
        let universities = realm.objects(University.self)
        return universities.map { $0.toResponse() }
    }
  
    public func deleteAllUniversities() {
        try! realm.write {
            let universities = realm.objects(University.self)
            realm.delete(universities)
        }
    }
}
