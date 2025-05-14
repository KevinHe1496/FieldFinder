//
//  Establishment-coordinate.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 14/5/25.
//

import Foundation
import CoreLocation

extension Establecimiento {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
