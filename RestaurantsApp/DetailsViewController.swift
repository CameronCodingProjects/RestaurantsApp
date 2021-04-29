//
//  DetailsViewController.swift
//  RestaurantsApp
//
//  Created by Field Employee on 4/20/21.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    private var mapView: MKMapView!
    private var lng: Double?
    private var lat: Double?
    private var address: String?
    private var number: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func setupVC(_ restaurant: Restaurant) {
        mapView = MKMapView(frame: CGRect(x: 10, y: 40, width: view.frame.width - 20, height: view.frame.height / 3))
        
        let initialView = CLLocation(latitude: restaurant.location.lat, longitude: restaurant.location.lng)
        mapView.centerToLocation(initialView)
        view.addSubview(mapView)
        
        let addressLabel = UILabel()
        let location = restaurant.location
        addressLabel.text = "\(location.address) \(location.city)"
        addressLabel.textColor = .black
        addressLabel.font = .boldSystemFont(ofSize: 16)
        addressLabel.numberOfLines = 0
        self.view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
        
        
        if let number = restaurant.contact?.phone {
            let numberLabel = UILabel()
            numberLabel.text = number
            numberLabel.textColor = .black
            numberLabel.font = .boldSystemFont(ofSize: 16)
            numberLabel.numberOfLines = 0
            self.view.addSubview(numberLabel)
            numberLabel.translatesAutoresizingMaskIntoConstraints = false
            numberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 20).isActive = true
            numberLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            numberLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 10).isActive = true
        }
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 100
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
