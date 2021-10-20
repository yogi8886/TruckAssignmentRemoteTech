//
//  ViewController.swift
//  TruckAssignmentRemoteTech
//
//  Created by Yogesh on 16/10/21.
//

import UIKit
import GoogleMaps
import CoreLocation



class ViewController: UIViewController {

  @IBOutlet var navigationView: UIView!
  @IBOutlet var mainBackView: UIView!
  @IBOutlet var menuButton: UIButton!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var mapButton: UIButton!
  @IBOutlet var searchButton: UIButton!
  @IBOutlet var syncButton: UIButton!
  @IBOutlet var mapView: UIView!
  @IBOutlet var truckListTableView: UITableView!
  var selectedView = "list"
  var truckLocationArray:[truckData]! = []
  var locationManager: CLLocationManager!
  var latitude, longitude: Double!
  var refreshOne = true

  
  override func viewDidLoad() {
    super.viewDidLoad()
    latitude = 0.0
    longitude = 0.0
    
//    if (CLLocationManager.locationServicesEnabled())
//    {
      locationManager = CLLocationManager()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.requestAlwaysAuthorization()
      locationManager.startUpdatingLocation()
//    }
    
    truckListServiceMethod()
  }
  
  func listDesignMethod(){
    truckListTableView.delegate = self
    truckListTableView.dataSource = self
    truckListTableView.estimatedRowHeight = 100
    truckListTableView.rowHeight = UITableView.automaticDimension
    truckListTableView.reloadData()
  }
  
  func mapDesignMethod(){
    
    var bounds = GMSCoordinateBounds()
    let camera = GMSCameraPosition.camera(withLatitude: 30.757892608642578, longitude: 76.13253021240234, zoom: 10.0)
    let mapVieww = GMSMapView.map(withFrame: mapView.bounds, camera: camera)
    mapView.addSubview(mapVieww)
    
    for x in 0..<truckLocationArray.count + 1 {
      let marker = GMSMarker()

      if truckLocationArray.count != x {
        let item = truckLocationArray[x]
        let latt : CLLocationDegrees! = item.lastWaypoint?.lat
        let long : CLLocationDegrees! = item.lastWaypoint?.lng
        marker.position = CLLocationCoordinate2DMake(latt, long)
        if item.lastRunningState?.truckRunningState == 0 && item.lastWaypoint?.ignitionOn == true {
          marker.icon = UIImage.init(named: "truckYellow")
        }
        else if item.lastRunningState?.truckRunningState == 0 && item.lastWaypoint?.ignitionOn == false {
          marker.icon = UIImage.init(named: "truck")
        }
        else if item.lastRunningState?.truckRunningState == 1  {
          marker.icon = UIImage.init(named: "truckGreen")
        }
        else{
          marker.icon = UIImage.init(named: "truckRed")
        }
        
      }
      else
      {
        if latitude != 0.0 {
          marker.position = CLLocationCoordinate2DMake(latitude, longitude)
          marker.icon = UIImage.init(named: "placeholder")
        }
        
      }
      
      marker.map = mapVieww
      bounds = bounds.includingCoordinate(marker.position)
    }
    
    
    
    mapVieww.setMinZoom(1, maxZoom: 15)
    let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
    mapVieww.animate(with: update)
    mapVieww.setMinZoom(1, maxZoom: 20)
  }

  @IBAction func menuButtonAction(_ sender: UIButton) {
  }
  
  @IBAction func syncButtonAction(_ sender: UIButton) {
    truckListServiceMethod()
  }
  
  @IBAction func mapButtonAction(_ sender: UIButton) {

    if selectedView == "list" {
      mainBackView.isHidden = true
      mapView.isHidden = false
      selectedView = "map"
      mapButton.setImage(UIImage.init(named: "list"), for: .normal)
      searchButton.isHidden = true
      syncButton.frame = CGRect(x: navigationView.frame.size.width-85, y: 10, width: 30, height: 30)
    }
    else{
      selectedView = "list"
      mainBackView.isHidden = false
      mapView.isHidden = true
      mapButton.setImage(UIImage.init(named: "map"), for: .normal)
      searchButton.isHidden = false
      syncButton.frame = CGRect(x: navigationView.frame.size.width-130, y: 10, width: 30, height: 30)
    }
    
  }
  
  @IBAction func searchButtonAction(_ sender: Any) {
  }
  
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return truckLocationArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TruckListTableViewCell", for: indexPath) as! TruckListTableViewCell
    
    
    applyShadowOnView(cell.rectBackView)
    let details = truckLocationArray[indexPath.row]
    cell.truckNumberLabel.text = details.truckNumber

    cell.timeLabel.text = Date(milliseconds: Int64((details.lastWaypoint?.createTime)!)).timeAgoSinceDateInt()
    cell.daysAgoLabel.text = Date(milliseconds: Int64((details.lastWaypoint?.createTime)!)).timeAgoSinceDate()
    if let speed = details.lastWaypoint?.speed {
      if speed != 0 {
        cell.speedLabel.text = "\(speed)"
        cell.kmhrLabel.text = "k/h"
      }
      else{
        cell.speedLabel.text = ""
        cell.kmhrLabel.text = ""
      }
    }
    else{
      cell.speedLabel.text = ""
      cell.kmhrLabel.text = ""
   }
//    
    if let runState = details.lastRunningState?.truckRunningState {
      
      if runState == 0 {
        cell.truckRunStateLabel.text = "Stopped since last \(Date(milliseconds: Int64((details.lastRunningState?.stopStartTime)!)).timeAgoSinceDate2())"
        if details.lastRunningState?.truckRunningState == 0 && details.lastWaypoint?.ignitionOn == true {
          cell.truckImg.image = UIImage.init(named: "ignition")
        }
        else if details.lastRunningState?.truckRunningState == 0 && details.lastWaypoint?.ignitionOn == false {
          cell.truckImg.image = UIImage.init(named: "truckGray")
        }
      }
      else{
        cell.truckRunStateLabel.text = "Running since last \(Date(milliseconds: Int64((details.lastRunningState?.stopStartTime)!)).timeAgoSinceDate2())"
        cell.truckImg.image = UIImage.init(named: "truckGray")
      }

    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
}

extension ViewController
{
  func truckListServiceMethod()
  {
    var paramDict :[String:Any]?
    paramDict=["auth-company":"PCH", "companyId":"33", "deactivated":"false", "key":"g2qb5jvucg7j8skpu5q7ria0mu", "q-expand":"true", "q-include":"lastRunningState,lastWaypoint"]
        
    ServiceHandler.sharedInstance.getServiceMethodModelWise2(params: paramDict!,apiName:"https://api.mystral.in/tt/mobile/logistics/searchTrucks" ,completion: { (result , error ) in
      DispatchQueue.main.async {
        if let result = result
        {
          let resData = try? JSONDecoder().decode(TrucksModel.self,
                                                  from: result)
          if resData?.responseCode.message.lowercased() == "success"  {
            self.truckLocationArray = resData?.data
            self.listDesignMethod()
            self.mapDesignMethod()
          }
        }
        else if let error = error
        {
          print("error: \(error.localizedDescription)")
        }
      }
    })
  }
  
 
}

extension ViewController: CLLocationManagerDelegate{
  
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
  {
    let location = locations.last! as CLLocation
    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    latitude = location.coordinate.latitude
    longitude = location.coordinate.longitude
    if refreshOne {
      refreshOne = false
      self.mapDesignMethod()
    }
    print(center)
  }
}


func applyShadowOnView(_ view:UIView) {
  view.layer.cornerRadius = 8
  view.layer.shadowColor = UIColor.lightGray.cgColor
  view.layer.shadowOpacity = 0.5
  view.layer.shadowOffset = CGSize.zero
  view.layer.shadowRadius = 5
}
