//
//  ViewController.swift
//  Full Forcast weather app
//
//  Created by A One Way To Allah on 7/5/18.
//  Copyright © 2018 A One Way To Allah. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    
    //MARK: - VARIABLES
    var cw=CurrentWeather()
    var arrForcasts=[Forcast]()
    
    var lm=CLLocationManager()
    var cl:CLLocation!

    //MARK: - FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        lm.delegate=self
        lm.desiredAccuracy=kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        lm.startMonitoringSignificantLocationChanges()
        
      
   
    }
    
    func updateDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self.dateLabel.text=currentDate
    }
    
    func downloadForcastData(completed:@escaping DownloadComplete){
        
        Alamofire.request(FORCAST_URL).responseJSON{response in
            let resault=response.result
            
            if let dict=resault.value as? [String:Any]{
                if let list=dict["list"] as? [[String:Any]]{
                    for obj in list{
                        let fr=Forcast(weatherDict: obj)
                        self.arrForcasts.append(fr)
                        print(obj)
                    }
                }
                self.table.reloadData()
            }
            completed()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }

    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            cl=lm.location
            Location.sharedInstance.lat=cl.coordinate.latitude
            Location.sharedInstance.lon=cl.coordinate.longitude
            cw.downloadWeatherdetails {
                self.downloadForcastData {
                    self.updateDate()
                    self.updateUI()
                }
                
            }
            

        }else{
            lm.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    
    
    func updateUI(){
        currentTempLabel.text="\(self.cw.currntTemp)"
        locationLabel.text=self.cw.cityName
        currentWeatherTypeLabel.text=self.cw.weatherType
     currentWeatherImage.image=UIImage(named: cw.weatherType)
    }


}
   //MARK: - EXTERNTION
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myCell {
            
            let list = arrForcasts[indexPath.row]
            
cell.configureCell(forecast: list)
            return cell
            
        } else {
            return myCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForcasts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

