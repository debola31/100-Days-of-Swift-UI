//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by ADEBOLA AKEREDOLU on 8/21/23.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    init(filterKey: String, filterValue: String, predicate: Predicates, sorters: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sorters, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        self.content = content
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    enum Predicates: String {
        case beginsWith = "BEGINSWITH"
        case like
        case lessThan = "<"
        case greaterThan = ">"
    }
}
