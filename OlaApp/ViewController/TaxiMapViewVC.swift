//
//  MapViewVC.swift
//  OlaApp
//
//  Created by Muneer KK on 25/11/19.
//  Copyright © 2019 Muneer KK. All rights reserved.
//

import UIKit
import MapKit
private typealias MapViewMethods = TaxiMapViewVC
class TaxiMapViewVC: UIViewController {
@IBOutlet weak var mapView: MKMapView!
    var taxiListVM = TaxiListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //MARK:- Methods to Load All the Annotation from the Taxi List
        loadMapViewAnnotation()

        // Do any additional setup after loading the view.
    }
    //MARK:-Method to Show All CAR Annotation inside the MapView
    fileprivate func loadMapViewAnnotation(){
        
         //MARK:- Methods to create all annotation using Location objetcts(Lat & long)
        let annotations = taxiListVM.getAnnotations(from: taxiListVM.loadTaxiList().map{$0.location!})
        guard annotations.count > 0 else {
            return
        }
        mapView.delegate = self
         //MARK:- Methods to find out the centr region of the map, We assume that the first location will be the centre . This can be changed by using the requirements
        if let region = taxiListVM.getRegion(from: taxiListVM.loadTaxiList().map{$0.location!}){
            mapView.setRegion(region, animated: true)
        }
        mapView.showAnnotations(annotations, animated: true)
        mapView.addAnnotations(annotations)
    }

}
//MARK:- MapView Delegate Methods
extension MapViewMethods: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        let annotationIdentifier = ViewCellIdentifier.annotationView.rawValue
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }

        //MARK:- set default image as Annotation image. this can be set actual image from URL
        let pinImage = UIImage(named: OlaAppConstants.placeholderImage)
        annotationView!.image = pinImage
        
        return annotationView
    }
}
