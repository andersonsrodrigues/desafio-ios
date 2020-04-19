//
//  CharacterData.swift
//  desafio-ios-anderson-rodrigues
//
//  Created by Anderson Rodrigues on 15/04/2020.
//  Copyright © 2020 Anderson Rodrigues. All rights reserved.
//

import Foundation

struct CharacterData: Decodable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail: ImageData?
    var comics: ResourceData?
}
