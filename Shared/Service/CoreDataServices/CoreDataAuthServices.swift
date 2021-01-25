
import Foundation
import CoreData
import SwiftUI

extension CoreDataService {
    
    func updateAuthDetailToken(entity: String, token: String) -> (CoreDataErrors?){
        var fetchedData: [NSManagedObject]
        fetchedData = fetch(entity).1
        fetchedData[0].setValue(token, forKey: "token")
        return save()
    }
    
}
