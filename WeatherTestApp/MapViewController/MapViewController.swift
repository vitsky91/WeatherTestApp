//
//  MapViewController.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/10/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let distanceOnMap: Double = 500
    
    let locationManager = CLLocationManager()
    
    private var pickedLatitude: Double = 0
    private var pickedLongtitude: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.handleLongPress(_:)))
        longPressRecogniser.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressRecogniser)
    }
    
    func centerOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: distanceOnMap, longitudinalMeters: distanceOnMap)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuth()
        }
    }
    
    func checkLocationAuth() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state != .began { return }

        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

        let pointOnMap = MKPointAnnotation()
//        pointOnMap.title = "London"
        pointOnMap.coordinate = CLLocationCoordinate2D(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)

        pickedLatitude = touchMapCoordinate.latitude
        pickedLongtitude = touchMapCoordinate.longitude
        
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        mapView.addAnnotation(pointOnMap)
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: distanceOnMap, longitudinalMeters: distanceOnMap)
        
        
        //mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuth()
    }
    
    
}

// MARK: - @IBAction
extension MapViewController {
    
    @IBAction func closeDidTapped() {
        locationManager.stopUpdatingLocation()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveDidTapped() {
        locationManager.stopUpdatingLocation()
        
        NetworkManger.shared.getWeatherData(lon: pickedLongtitude, lat: pickedLatitude)
        
        dismiss(animated: true, completion: nil)
    }
}
