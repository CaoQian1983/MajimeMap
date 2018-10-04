//
//  ThirdViewController.swift
//  MajimeMapApp
//
//  Created by CaoQian on 2018/09/25.
//  Copyright © 2018 CaoQian. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}

class ThirdViewController: UIViewController,CLLocationManagerDelegate{

    var latitude : CLLocationDegrees!
    
    var longtitude : CLLocationDegrees!
    
    var start:CLLocation!
   
    @IBOutlet weak var MapView: MKMapView!

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        //userdefaultのデータを読み込む
        // String to be filled with the saved value from UserDefaults
        var str1:String = ""
        var str2:String = ""
        // Get the standard UserDefaults as "defaults"
        let defaults = UserDefaults.standard
        
        
        
        
        // Get the saved String from the standard UserDefaults with the key, "DataStore"
    
        str1 = defaults.object(forKey: "DataStore1") as! String
        //住所を座標に変換する。
        let myGeocoder:CLGeocoder = CLGeocoder()

//        var StrLatitude : sourceLocation!
//        var StrLongitude : sourceLocation!
        
        
        var str1Latitude = CLLocationDegrees()
        var str1Longitude = CLLocationDegrees()
        var myLocation:CLLocation!
        var targetLocation:CLLocation!
        var placemark1 = String()
        var placemark2 = String()
        
        myGeocoder.geocodeAddressString(str1, completionHandler: {(placemarks, error) in
           
            if(error == nil) {
                for placemark in placemarks! {
                    print("placemarkの中身；",placemark)
                    let location:CLLocation = placemark.location!
                    let myLocation = placemark.location!
                    print("location;",location)
                    //中心座標
                    let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                    print("latitude",location.coordinate.latitude)
                    print("Longitude", location.coordinate.longitude)
                    
                    str1Latitude = location.coordinate.latitude
                    str1Longitude = location.coordinate.longitude
                    
                    placemark1 = placemark.name!
           
                    self.start = location
                    
                    let myGeocoder2:CLGeocoder = CLGeocoder()
                    
                    
                    var str2Latitude = CLLocationDegrees()
                    var str2Longitude = CLLocationDegrees()
                    str2 = defaults.object(forKey: "DataStore2") as! String
                    //住所を座標に変換する。
                    
                    myGeocoder2.geocodeAddressString(str2, completionHandler: {(placemarks, error) in
                        
                        if(error == nil) {
                            for placemark in placemarks! {
                                print("placemarkの中身2；",placemark)
                                let location:CLLocation = placemark.location!
                                let targetLocation = placemark.location!
                                print("location;",location)
                                //中心座標
                                let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
                                print("latitude",location.coordinate.latitude)
                                print("Longitude", location.coordinate.longitude)

                                placemark2 = placemark.name!
                                str2Latitude = location.coordinate.latitude
                                str2Longitude = location.coordinate.longitude
                                
                                var imageNumber = defaults.object(forKey: "DataStore3") as! Int
                                print(imageNumber)
                                
                                var photos = ["dambbell","2x.jpg","3x.png","4x.jpg","5x.png","6x.png","7x.jpg","8x"]
                                
                                self.imageView.image = UIImage(named:photos[imageNumber])
                                
                                //let DataStore: String? = userDefaults.object(forKey: "DataStore") as? String
                                // 入力された駅名等をジオコーディング
                                //住所
                                //let searchStr = UITextField.text
                                //住所を座標に変換する。
                                //改行を入れな
                                let sourceLocation = CLLocationCoordinate2D(latitude: str1Latitude, longitude:str1Longitude)
                                print (sourceLocation)
                                let destinationLocation = CLLocationCoordinate2D(latitude:str2Latitude,longitude:str2Longitude)
                                print (destinationLocation)
                                let distance = myLocation.distance(from: targetLocation)
                                print("中身は",distance)
                                
                                let sourcePin = customPin(pinTitle: placemark1, pinSubTitle: "", location: sourceLocation)
                                let destinationPin = customPin(pinTitle: placemark2, pinSubTitle: "", location: destinationLocation)
                                self.MapView.addAnnotation(sourcePin)
                                self.MapView.addAnnotation(destinationPin)
                                
                                let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
                                let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
                                
                                let directionRequest = MKDirections.Request()
                                directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
                                directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
                                directionRequest.transportType = .automobile
                                
                                let directions = MKDirections(request: directionRequest)
                                directions.calculate { (response, error) in
                                    guard let directionResonse = response else {
                                        if let error = error {
                                            print("we have error getting directions==\(error.localizedDescription)")
                                        }
                                        return
                                    }
                                    
                                    let route = directionResonse.routes[0]
                                    self.MapView.addOverlay(route.polyline, level: .aboveRoads)
                                    
                                    let rect = route.polyline.boundingMapRect
                                    self.MapView.setRegion(MKCoordinateRegion(rect), animated: true)
                                }
                                
                                //set delegate for mapview
                                self.MapView.delegate = self
                            }
                        } else {
                            print("検索できませんでした。")
                        }
                    })
                }
            } else {
                print("検索できませんでした。error",error)
            }
        })
        

    }
    
    
    //MARK:- MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
//    func calculateDistancefrom(sourceLocation: MKMapItem, destinationLocation: MKMapItem, doneSearching: @escaping (_ expectedTravelTim: TimeInterval) -> Void) {
//
//        let request: MKDirections.Request = MKDirections.Request()
//
//        request.source = sourceLocation
//        request.destination = destinationLocation
//        request.requestsAlternateRoutes = true
//
//        let directions = MKDirections(request: request)
//        directions.calculate { (directions, error) in
//
//            if var routeResponse = directions?.routes {
//                routeResponse.sort(by: {$0.expectedTravelTime <
//                    $1.expectedTravelTime})
//                let quickestRouteForSegment: MKRoute = routeResponse[0]
//
//                doneSearching(quickestRouteForSegment.distance)
//
//            }
//        }
//    }
//
//    func getDistance(lat: Double, lon: Double, completionHandler: @escaping (_ distance: Int) -> Void) {
//
//        let destinationItem =  MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(lat, lon)))
//        guard let currentLocation = sourceLocation.location else { return }
//        let sourceItem =  MKMapItem(placemark: MKPlacemark(coordinate: currentLocation.coordinate))
//
//        self.calculateDistancefrom(sourceLocation: sourceItem, destinationLocation: destinationItem, doneSearching: { distance in
//            completionHandler(distance)
//        })
//    }
    
    
    //Thereafter get the distance in meters by calling
    
//    self.getDistance(lat: yourLat, lon: YourLon) { distance in
//
//    }
    var oldPin : MKPointAnnotation!
    
    @IBAction func pressMap(_ sender: UILongPressGestureRecognizer) {
        
        if oldPin == nil {
            print (false)
        }else{
            MapView.removeAnnotation(oldPin!)
            print()
            print(true)
        }
       
        if sender.state != UIGestureRecognizer.State.ended {
            
            
            
            return
        }
        
        
        
        let myPin: MKPointAnnotation = MKPointAnnotation()
        
        // Get the coordinates of the point you pressed long.
        let location = sender.location(in: MapView)
        
        // Convert location to CLLocationCoordinate2D.
        let myCoordinate: CLLocationCoordinate2D = MapView.convert(location, toCoordinateFrom: MapView)
        
        // Generate pins.
        
        // Set the coordinates. ピンの場所
        myPin.coordinate = myCoordinate
        
        // Set the title.
        myPin.title = "title"
        
        // Set subtitle.
        myPin.subtitle = "subtitle"
        
        // Added pins to MapView.
        
        oldPin = myPin
        print("古いやつ",oldPin)
        print("新しいやつ",myPin)
        
        MapView.addAnnotation(myPin)
        

    }
}

extension ThirdViewController : MKMapViewDelegate {
    
    // Delegate method called when addAnnotation is done.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let myPinIdentifier = "PinAnnotationIdentifier"
        
        // Generate pins.
        let myPinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: myPinIdentifier)
        
        // Add animation.
        myPinView.animatesDrop = true
        
        // Display callouts.
        myPinView.canShowCallout = true
        
        // Set annotation.
        myPinView.annotation = annotation
        
        print("latitude: \(annotation.coordinate.latitude), longitude: \(annotation.coordinate.longitude)")
        
        return myPinView
    }
        
}
        //マップビュー内のタップした位置を取得する。
//        let location:CGPoint = sender.location(in: MapView)
//
//        //長押し終了
//        if (sender.state == UIGestureRecognizer.State.ended){
//
//            //タップした位置を緯度、経度の座標に変換する。
//            let mapPoint:CLLocationCoordinate2D = MapView.convert(location, toCoordinateFrom: MapView)
//            let location = CLLocation(latitude:mapPoint.latitude, longitude: mapPoint.longitude)
//
//            //座標を住所に変換する。
//            let myGeocoder:CLGeocoder = CLGeocoder()
//            myGeocoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
//
//                if(error == nil) {
//                    for placemark in placemarks! {
//
//                        //ピンを地図に刺す。
//                        let annotation = MKPointAnnotation()
//                        annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
//                        annotation.title = "住所"
//                        annotation.subtitle = "\(placemark.administrativeArea!)\(placemark.locality!)\(placemark.thoroughfare!)\(placemark.subThoroughfare!)"
//                        self.MapView.addAnnotation(annotation)
//                    }
//                }
//            })

//        myLocationManager = CLLocationManager()
//        myLocationManager.requestWhenInUseAuthorization()
//        mylocationManager.delegate = self
//        MapView.delegate = self
//        TextField.delegate = self
        

//}
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("error")
//    }
//
//    func locationManager(manager: CLLocationManager!,didUpdateLocations locations: [AnyObject]!){
//
//        userLocation = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude)
//
//        var userLocAnnotation: MKPointAnnotation = MKPointAnnotation()
//        userLocAnnotation.coordinate = userLocation
//        userLocAnnotation.title = "現在地"
//        mapView.addAnnotation(userLocAnnotation)
//    }
//
//    // 位置情報取得に失敗した時に呼び出されるデリゲート.
//    func locationManager(manager: CLLocationManager!,didFailWithError error: NSError!){
//        print("locationManager error")
//       
//    }
//    locationManager.startUpdatingLocation()
//}
//

