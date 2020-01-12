//
//  Quake.swift
//  EagleEye-Xcode
//
//  Created by Austin Potts on 1/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import CoreLocation

class Quake: NSObject, Decodable {
    
    struct Properties: Decodable, Hashable {
        let mag: Double?
        let place: String
        let time: Date
        
        enum Alert: String, Decodable, Hashable {
            case green, yellow, orange, red
        }
        let alert: Alert?
    }
    
    struct Geometry: Decodable, Hashable {
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: GeometryCodingKeys.self)
            var coordinates = try container.nestedUnkeyedContainer(forKey: .coordinates)
            let longitude = try coordinates.decode(CLLocationDegrees.self)
            let latitude = try coordinates.decode(CLLocationDegrees.self)
            
            location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        
        let location: CLLocationCoordinate2D
        
        enum GeometryCodingKeys: CodingKey {
            case coordinates
        }
        
        static func ==(lhs: Geometry, rhs: Geometry) -> Bool {
            return lhs.location.latitude == rhs.location.latitude &&
                lhs.location.longitude == rhs.location.longitude
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(location.latitude)
            hasher.combine(location.longitude)
        }
    }
    
    let id: String
    let properties: Properties
    let geometry: Geometry

    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(id)
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Quake else { return false }
        return other.id == id
    }
}

struct QuakeResults: Decodable {
    let features: [Quake]
}
