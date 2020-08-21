//
//  Photo+Extention.swift
//  virtualTourist
//
//  Created by A Abdullah on 8/09/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

extension Photo {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        creationDate = Date()
    }
}
