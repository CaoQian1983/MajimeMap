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
import SwiftyGif
import AVFoundation

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
    
    let defaults = UserDefaults.standard
    
    var audioPlayerInstance : AVAudioPlayer! = nil
    
    var players:[AVAudioPlayer]!
    let audioFiles = ["test1","test2","test3","test4","test5","test6","test7","test8"]

    
    
    @IBOutlet weak var MapView: MKMapView!

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var label: UILabel!
    
   
    
        //gifイメージがタップされたときにする処理
        @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        audioPlayerInstance.currentTime = 0
//        audioPlayerInstance.play()
            let rabdomNum = Int.random(in: 0...players.count - 1)
        let player = players[rabdomNum]
            player.play()
//        play(n: 0)
//        play(n: 1)
//        play(n: 2)

    }
    
//    func play(n:Int) {
//        if n < players.count {
//            players[n].play()
//        }
//    }

    func setup() {
        players = []
        for fname in audioFiles {
            let path = URL(fileURLWithPath: Bundle.main.path(forResource: fname, ofType: "mp3")!)
            do {
                let player = try AVAudioPlayer(contentsOf:path)
                players.append(player)
            } catch let error as NSError {
                print("error has occurred: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
//        let soundFilePath = Bundle.main.path(forResource: "test3", ofType: "mp3")!
//        let sound:URL = URL(fileURLWithPath: soundFilePath)
//        // AVAudioPlayerのインスタンスを作成
//        do {
//            audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
//        } catch {
//            print("AVAudioPlayerインスタンス作成失敗")
//        }
//        // バッファに保持していつでも再生できるようにする
//        audioPlayerInstance.prepareToPlay()
        
        setup()
        
        var imageNumber = defaults.object(forKey: "DataStore3") as! Int
        print(imageNumber)
       
         var photos = ["dambbell2","hulahoop","skateboard","hofuku","yonsoku","unicycle","bakuten","jumprope","soccer","dribble"]
        print(photos[imageNumber])

        imageView.loadGif(name:photos[imageNumber])
        
         //gifのイメージにタップイベントを追加
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        //userdefaultのデータを読み込む
        // String to be filled with the saved value from UserDefaults
        var str1:String = ""
        var str2:String = ""
        // Get the standard UserDefaults as "defaults"
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
                    str2 = self.defaults.object(forKey: "DataStore2") as! String
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
                                
                    
//                                var photos = ["dambbell","2x.jpg","3x.png","4x.jpg","5x.png","6x.png","7x.jpg","8x"]
                                
//                                self.imageView.image = UIImage(named:photos[imageNumber])
//
//                                let gif = UIImage(gifName: "dambbell2.gif")
//                                let imageview = UIImageView(gifImage: gif, loopCount: -1) // Use -1 for infinite loop
//                                imageview.frame = self.view.bounds
//                                self.view.addSubview(imageview)
                                
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
                                let num1: Int = Int(floor(distance))
                                print(String(format: "%f", distance))
                                print("中身は",num1)
                               
                                
                                //Swiftに置ける型の変換の仕方。
                                //distanceの型をString型に変更する。
                                //ラベルへの文字の入れ方
                                self.label.text = num1.description + "メートル"
                                let _ : String; "中身は"
                                
                                
                                
                                
                               
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
    
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
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

