import Foundation
import CoreData
import SwiftUI



class CompaniesState: ObservableObject {
    @Published private(set) var companies = Set<Company>()
    
    @Published var selectedCompany = String()
    
    func selectCompany(company: String) {
        selectedCompany = company
    }
    
    func getCompaniesCategories() -> [String] {
        var categories = Set<String>()
        for company in self.companies {
            let categoriesString = String(company.name.first!)
            categories.insert(categoriesString)
        }
        var categoriesString = Array(categories)
        categoriesString = categoriesString.sorted { $0.first!.lowercased() < $1.first!.lowercased() }
        return categoriesString
    }
}
