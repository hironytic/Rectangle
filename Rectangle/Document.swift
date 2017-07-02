//
//  Document.swift
//  Rectangle
//
//  Created by ichi on 2017/07/02.
//  Copyright © 2017 Hironytic. All rights reserved.
//

import UIKit

struct Rectangle: Codable {
    var width: Float
    var height: Float
}

class Document: UIDocument {
    var rectangle = Rectangle(width: 0.0, height: 0.0)
    
    override func contents(forType typeName: String) throws -> Any {
        return try JSONEncoder().encode(rectangle)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        guard let data = contents as? Data else { return }
        rectangle = try JSONDecoder().decode(Rectangle.self, from: data)
    }
}

