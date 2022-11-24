//
//  openCard.swift
//  evernote redesign
//
//  Created by Valeed Abdul Hameed on 23/11/22.
//

import SwiftUI

struct openCard: View {
    @Binding var card : Card
    var body: some View {
        
        VStack{
            
              
            Text(card.title)
                .padding([.bottom, .trailing],300)
            
            Text(card.description)
                .padding([.bottom, .trailing],150)
        }
        
    }
    
}

struct openCard_Previews: PreviewProvider {
    
    static var previews: some View {
        openCard(card: .constant(Card(title: "Title test", description: "Random description to test the functionality")))
    }
}
