//
//  MapViewController.swift
//  EagleEye-Xcode
//
//  Created by Austin Potts on 1/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

     override func viewDidLoad() {
           super.viewDidLoad()
           
           locationManager.requestWhenInUseAuthorization()
           
           userTrackingButton = MKUserTrackingButton(mapView: mapView)
           userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
           mapView.addSubview(userTrackingButton)
           userTrackingButton.leftAnchor.constraint(equalTo: mapView.leftAnchor, constant: 20.0).isActive = true
           mapView.bottomAnchor.constraint(equalTo: userTrackingButton.bottomAnchor, constant: 20.0).isActive = true
           
           // Add these two lines when you get to the "Annotations" section of the lesson plan.
           mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "QuakeAnnotationView")
           
           fetchQuakes()
       }
       
       // MARK: - MKMapViewDelegate
       
       func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
           fetchQuakes()
       }
       
       func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           guard let quake = annotation as? Quake else { return nil }
           
           let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "QuakeAnnotationView", for: quake) as! MKMarkerAnnotationView
           annotationView.glyphTintColor = .white
           annotationView.glyphImage = UIImage(named: "QuakeIcon")!
           
           // ------ Add this later ------
           annotationView.canShowCallout = true
           let detailView = QuakeDetailView(frame: .zero)
           detailView.quake = quake
           annotationView.detailCalloutAccessoryView = detailView
           // ----------------------------
           
           return annotationView
       }
       
       // MARK: - Private
       
       private func fetchQuakes() {
           let visibleRegion = CoordinateRegion(mapRect: mapView.visibleMapRect)
           quakeFetcher.fetchQuakes(in: visibleRegion) { (quakes, error) in
               if let error = error {
                   NSLog("Error fetching quakes: \(error)")
               }
               
               self.quakes = quakes ?? []
           }
       }
       
       // MARK: - Properties
       
       private let quakeFetcher = QuakeFetcher()
       private var quakes = [Quake]() {
           didSet {
               let oldQuakes = Set(oldValue)
               let newQuakes = Set(quakes)
               let addedQuakes = Array(newQuakes.subtracting(oldQuakes))
               let removedQuakes = Array(oldQuakes.subtracting(newQuakes))
               DispatchQueue.main.async {
                   self.mapView.removeAnnotations(removedQuakes)
                   self.mapView.addAnnotations(addedQuakes)
               }
           }
       }

       private let locationManager = CLLocationManager()
       
       @IBOutlet weak var mapView: MKMapView!
       private var userTrackingButton: MKUserTrackingButton!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
