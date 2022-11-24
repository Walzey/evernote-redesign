//
//  cardView.swift
//  evernote redesign
//
//  Created by Valeed Abdul Hameed on 22/11/22.
//

import SwiftUI

struct cardView: View {
    @Binding var cardList : [Card]
    @Binding var card: Card
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 1).frame(width: 150,height: 200)
            VStack(spacing:40){
                HStack{
                    Text(card.title).foregroundColor(.black)
                    Spacer()
                    Button {
                        let idx = cardList.firstIndex(where: {$0.id == card.id})!
                        cardList[idx].isFavorited.toggle()
                        saveCard("card", cardList)
                    } label: {
                        Image(systemName: card.isFavorited ? "star.fill": "star").foregroundColor(.blue)
                    }
                    
                    
                }
                Text(card.description).fontWeight(.light)
                Spacer()
            }.frame(width: 130,height: 190,alignment: .leading)
            
        }
    }
}

