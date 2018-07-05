
import Foundation

typealias DownloadComplete = ()->()



let MAIN_URL2="https://samples.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lat)&lon=\(Location.sharedInstance.lon)&appid=b6907d289e10d714a6e88b30761fae22"


let MAIN_URL="http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.lat)&lon=\(Location.sharedInstance.lon)&appid=bed76a96052519cd51a5b291cdd974c2"


let FORCAST_URL="https://samples.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.lat)&lon=\(Location.sharedInstance.lon)&cnt=10&appid=appid=bed76a96052519cd51a5b291cdd974c2"
