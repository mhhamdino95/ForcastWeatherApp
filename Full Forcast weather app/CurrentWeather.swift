

import Foundation
import Alamofire

class CurrentWeather{
    
    var cityName:String!
    var date:String!
    var weatherType:String!
    var currntTemp=0
    
    
    func downloadWeatherdetails(completed:@escaping DownloadComplete){
        Alamofire.request(MAIN_URL).responseJSON { (response) in
            let resault=response.result
            if let dict=resault.value as? [String:Any]{
                if let name=dict["name"] as? String{
                    self.cityName=name.capitalized
                }
                if let main=dict["main"] as? [String:Any]{
                    if let temp=main["temp"] as? Double{
                        self.currntTemp=Int(temp-273.15)
                    }
                    if let weather=dict["weather"] as? [[String:Any]]{
                        if let main=weather[0]["main"] as? String{
                            self.weatherType=main
                        }
                    }
                }
                
            }
            completed()
            
        }
            
        }
    }
    
    
    

