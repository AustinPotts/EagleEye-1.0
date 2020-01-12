//
//  Quake+Mapping.swift
//  EagleEye-Xcode
//
//  Created by Austin Potts on 1/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import MapKit

extension Quake: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return geometry.location
    }
    
    var title: String? {
        return properties.place
    }
}
