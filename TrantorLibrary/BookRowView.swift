//
//  BookRowView.swift
//  TrantorLibrary
//
//  Created by Angel Fernandez Barrios on 28/2/23.
//

import SwiftUI

struct BookRowView: View {
    @EnvironmentObject var vm: GeneralViewModel
    let book: Book
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 90, height: 130)
                    .foregroundColor(.black)
                    .overlay {
                        CoverView(url: book.cover)
                    }
                    .padding(.leading)
                
                VStack {
                    Text(book.title)
                        .font(.callout.bold())
                        .lineLimit(2)
                    Text(vm.authors[book.author] ?? "Not Available")
                        .font(.caption.bold())
                    RatingView(rating: book.rating ?? 0, size: 10)
                    
                    HStack {
                        Text("\(book.price.description)€")
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Button {
                            vm.addToCart(book: book.id)
                        } label: {
                            Label("Buy", systemImage: "cart")
                                .foregroundColor(.white)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color("Primary"))
                        
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            
            if vm.isReaded(id: book.id) {
                Image(systemName: "bookmark.fill")
                    .resizable()
                    .frame(width: 20, height: 30)
            }
        }
        .frame(width: 350, height: 150)
        .foregroundColor(Color("Primary"))
    }
}

struct BookRowView_Previews: PreviewProvider {
    static var previews: some View {
        BookRowView(book: .test)
            .environmentObject(GeneralViewModel())
    }
}
