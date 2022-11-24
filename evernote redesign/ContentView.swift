//
//  ContentView.swift
//  evernote redesign
//
//  Created by Valeed Abdul Hameed on 22/11/22.
//

import SwiftUI

struct ContentView: View {
    @State var addCard : Card = Card()
    @State var searchText : String = ""
    @State var addModal : Bool = false
    @State var addTask : Bool = false
    @State var selectedOrder : String = "All"
    @State var scratchText : String = ""
    let orderSelection : [String] = ["All","Favorite"]
    let typeSelection : [String] = ["Web clips","Images","Doc","Audio","Email"]
    @State var cardList : [Card] = cardJSON
    
    var body: some View {
        NavigationStack{
            VStack(spacing:30){
                HStack{
                    Text("NOTES")
                    Spacer()
                    Button {
                        addModal = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
                Picker("Selection", selection: $selectedOrder) {
                    ForEach(orderSelection,id:\.self) { sel in
                        Text(sel)
                    }
                }.pickerStyle(.segmented)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack(spacing:25){
                        ForEach(searchResults) { card in
                            if (selectedOrder == "Favorite"){
                                if (card.isFavorited){
                                    NavigationLink {
                                        openCard(card: $cardList.first(where: {$0.id == card.id})!)
                                    } label: {
                                        cardView(cardList: $cardList, card: $cardList.first(where: {$0.id == card.id})!)
                                    }

                                    
                                }
                            }else {
                                NavigationLink {
                                    openCard(card: $cardList.first(where: {$0.id == card.id})!)
                                } label: {
                                    cardView(cardList: $cardList, card: $cardList.first(where: {$0.id == card.id})!)
                                }
                            }
                        }.foregroundColor(.black)
                    }
                }
                
                             
            HStack{
                    Text("Scratch Pad")
                    Spacer()
                    Button {
                        if (!scratchText.isEmpty) {
                            addCard.description = scratchText
                            addCard.title = ""
                            cardList.append(Card(title:addCard.title,description: addCard.description))
                            addCard.title = ""
                            addCard.description = ""
                            saveCard("card", cardList)
                        }
                    } label: {
                        Image(systemName: "plus.circle").tint(scratchText.isEmpty ? .gray : .blue).opacity(scratchText.isEmpty ? 0.6 : 1)
                    }

                }
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1).frame(height: 100).foregroundColor(.yellow)
                    TextField("Note", text: $scratchText, prompt: Text("How to work with these?"),axis: .vertical).padding()
                }
                HStack{
                    Spacer()
                    Text("Max 150 characters").font(.footnote).fontWeight(.thin).opacity(0.4)
                    
                }
                    Spacer()
            }.padding().sheet(isPresented: $addModal) {
                Section {
                    TextField("Title", text: $addCard.title, prompt: Text("Insert title"))
                    TextField("Description", text: $addCard.description
                              , prompt: Text("Insert description"))
                }.padding().textFieldStyle(.roundedBorder)
                Button {
                    if(addCard.title != "" && addCard.description != ""){
                        cardList.append(Card(title:addCard.title,description: addCard.description))
                        addCard.title = ""
                        addCard.description = ""
                        saveCard("card", cardList)
                        addModal = false
                    }
                } label: {
                    Label("Add note", systemImage: "plus")
                }
            }
        }.searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search through evernote").autocorrectionDisabled(true)
    }
    var searchResults : [Card] {
        if (searchText.isEmpty){
            return cardList
        } else {
            return cardList.filter {$0.title.localizedCaseInsensitiveContains(searchText) || $0.description.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
