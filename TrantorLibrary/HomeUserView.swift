//
//  HomeUserView.swift
//  TrantorLibrary
//
//  Created by Angel Fernandez Barrios on 22/2/23.
//

import SwiftUI

struct HomeUserView: View {
    @EnvironmentObject var vm: GeneralViewModel
    let gradient = LinearGradient(colors: [.blue, .white], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack (alignment: .leading){
                        Text("HELLO,\(vm.userData.name.uppercased())")
                            .font(.title2.bold())
                            .foregroundColor(Color("Primary"))
                            .lineLimit(1)
                            .padding(5)

                        Text("Today's recommendation")
                            .font(.title.bold())
                            .foregroundColor(Color("Primary"))
                            .padding(5)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                    }
                    Spacer()
                }
                .padding(.leading)
                VStack {
                    if !vm.loading {
                        ProgressView()
                            .frame(height: 180)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(vm.latest) { book in
                                    NavigationLink(value: book) {
                                        CoverView(url: book.cover)
                                            .frame(width: 120, height: 180)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
                .padding(.bottom, 40)
                
                VStack(alignment: .leading) {
                    Text("Categories")
                        .font(.title.bold())
                        .foregroundColor(Color("Primary"))
                        .padding(5)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.leading)
                        .padding(.bottom)
                    List(Categories.allCases, id: \.self) { category in
                        NavigationLink(value: category) {
                            Text(category.rawValue)
                                .padding(.vertical, 5)
                        }
                        .listRowBackground(Color("Primary").opacity(0.2))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .foregroundColor(Color("Primary"))
                    .bold()
                    .padding(.horizontal)
                }
                .navigationDestination(for: Categories.self) { category in
                    SortCatalogueView(category: category)
                }
                Spacer()
            }
            .padding(.top)
        }
    }
}

struct HomeUserView_Previews: PreviewProvider {
    static let vm = GeneralViewModel()
    static var previews: some View {
        HomeUserView()
            .environmentObject(vm)
            .task {
                await vm.getLatest()
            }
    }
}
