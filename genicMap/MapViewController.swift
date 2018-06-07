//  ViewController.swift
//  genicMap
//  Created by okumura reo on 2018/06/04.
//  Copyright © 2018年 reo. All rights reserved.
import UIKit
import MapKit

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let latDelta:CLLocationDegrees = 0.5
    let lonDelta:CLLocationDegrees = 0.5
    let location = CLLocationCoordinate2DMake(35.681167, 139.767052)
    let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
    let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    mapView.setRegion(region, animated: true)
    prepareInstagram()
  }
  
  private func prepareInstagram() {
    //    Instagram.fetchInstagramData(lat: 35.681167, lng: 139.767052) { (instagramData) in
    Instagram.fetchInstagramData { (instagramData) in
      DispatchQueue.main.async {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.instagramData = instagramData
        self.addAnotations()
      }
    }
  }
  
  private func addAnotations() {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.instagramData?.data.forEach { d in
      switch d.location {
      case .some:
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake((d.location?.latitude)!, (d.location?.longitude)!)
        annotation.title = d.location?.name
        annotation.subtitle = d.caption.text
        self.mapView.addAnnotation(annotation)
      case .none:
        break
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
