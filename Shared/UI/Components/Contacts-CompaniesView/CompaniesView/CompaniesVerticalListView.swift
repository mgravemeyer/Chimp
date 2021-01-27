import SwiftUI

struct CompaniesVerticalListView: View {

    @EnvironmentObject var companiesState: CompaniesState
    @State var categorie: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(self.categorie).font(.system(size: 30)).fontWeight(.bold).padding(.trailing, 10).frame(width: 40)
            VStack(alignment: .leading) {
                ForEach(Array(companiesState.companies), id: \.self) { company in
                    if String(company.name.first!) == categorie {
                        if company.id.uuidString == companiesState.selectedCompany {
                            CompanyVerticalListItem(company: company, selected: true).padding(.bottom, 8)
                                .contextMenu {
                                    Button(action: {
//                                        createExternalContactDetailViewWindow(contact: contact)
                                    }) {
                                        Text("Create New Window")
                                    }
                                    Button(action: {
//                                        createExternalContactDetailViewWindow(contact: contact)
                                    }) {
                                        Text("Edit Contact")
                                    }
                                    Button(action: {
//                                        createExternalContactDetailViewWindow(contact: contact)
                                    }) {
                                        Text("Delete Contact")
                                    }
                                }
                        } else {
                            CompanyVerticalListItem(company: company, selected: false).padding(.bottom, 8)
                            .contextMenu {
                                Button(action: {
//                                    createExternalContactDetailViewWindow(contact: contact)
                                }) {
                                    Text("Create New Window")
                                }
                                Button(action: {
//                                    createExternalContactDetailViewWindow(contact: contact)
                                }) {
                                    Text("Edit Contact")
                                }
                                Button(action: {
//                                    createExternalContactDetailViewWindow(contact: contact)
                                }) {
                                    Text("Delete Contact")
                                }
                            }
                        }
                    }
                }
            }
            Spacer()
        }.padding(.top, 20)
    }
}
//hoverRow ? lightGray : Color.white
struct CompanyVerticalListItem: View {
    @EnvironmentObject var companiesState: CompaniesState
    @State var company: Company
    @State var selected: Bool
    @State var hoverRow = false
    let gray = Color(red: 207/255, green: 207/255, blue: 212/255)
    let lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
    var body: some View {
        ZStack(alignment: .leading) {
            Text("\(company.name)").lineLimit(1).padding(.trailing, -5).padding(.leading, 10).zIndex(1)
            RoundedRectangle(cornerRadius: 10).foregroundColor(selected || hoverRow ? lightGray : Color.white).onHover { (hover) in
                self.hoverRow = hover
            }
        }.frame(width: 180, height: 35).padding(.bottom, -13).onTapGesture {
            companiesState.selectCompany(company: company.id.uuidString)
        }
    }
}
