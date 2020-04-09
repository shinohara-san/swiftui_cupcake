//
//  Order.swift
//  CupcakeCorner
//
//  Created by Yuki Shinohara on 2020/04/08.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation

class Order: ObservableObject, Codable {
//     if we had used a struct, then any address details we had entered would disappear if we moved back to the original view.
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var type = 0
    @Published var quantity = 3

//    @Published var specialRequestEnabled = false
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
                //この処理をしないとspecialReqがfalseになってもextraやaddはtrueに変更してたらtrueのまま
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
//    challenge1
    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }

        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
//    CodingKeyはcodableに準拠するために必要なプロトコル
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
//        caseの省略
    }
    
    func encode(to encoder: Encoder) throws { //JSONに
        //Because that method is marked with throws, we don’t need to worry about catching any of the errors that are thrown inside – we can just use try without adding catch, knowing that any problems will automatically propagate upwards and be handled elsewhere.
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)

        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)

        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws { //Swiftfileに
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //containerにCodingKeysをキーに取得したデータを格納
        //欲しいデータごとに e.g. .typeというキーで取得したデータをIntに変換しそれをtypeに代入
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
//    上記二つが揃ってCodableに準拠できる
    
    init() { }
// a new initializer that can create an order without any data whatsoever
    //– it will rely entirely on the default property values we assigned
}
