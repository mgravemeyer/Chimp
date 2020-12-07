import SwiftUI

struct ChimpDatePicker: View {
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    @Binding var birthDate: Date
    
    var body: some View {
        DatePicker(selection: self.$birthDate, in: ...Date(), displayedComponents: .date) {
            Text("Select a date")
        }    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
