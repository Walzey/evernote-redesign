//
//  stickerModle.swift
//  StickerMakerStudio
//
//  Created by Valeed Abdul Hameed on 22/11/22.
//

import Foundation

var cardJSON: [Card] = loadCard("card")

func loadCard<T: Decodable>(_ filename: String) -> T {
    let data : Data
    do{
        let file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: true).appendingPathComponent(filename)
        data = try Data(contentsOf: file)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        saveCard(filename,[])
        return loadCard(filename)
    }
}

func saveCard (_ filename: String, _ pack: [Card]) -> Void {
    let data: Data
    do {
        let file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask,appropriateFor: nil, create: true).appendingPathComponent(filename)
        let encoder = JSONEncoder()
        data = try encoder.encode(pack)
        try data.write(to: file)
    } catch {
        fatalError("Couldn't save \(filename) from main bundle:\n\(error)")
    }
}
