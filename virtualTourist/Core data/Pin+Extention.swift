//
//  Pin+Extention.swift
//  virtualTourist
//
//  Created by A Abdullah on 8/09/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import MapKit

extension Pin: MKAnnotation {
    
    public override func awakeFromInsert() {
           super.awakeFromInsert()
           creationDate = Date()
       }
    public var coordinate: CLLocationCoordinate2D {
        
        let lat = CLLocationDegrees(latitude)
        let long = CLLocationDegrees(longitude)
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
