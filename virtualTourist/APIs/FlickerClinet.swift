//
//  FlickerClinet.swift
//  virtualTourist
//
//  Created by A Abdullah on 8/09/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import MapKit

class FlickerClient {
    
    struct Auth{
    static let apiKey = "6ab5198e7b53ed7daa61d570dc641ecb"
    static let Secret = "0a470e02bd42ef02"
    }
    
    
    class func createBlackBox(withLat latitude: Double,withLong longitude: Double) -> String{
          
    let minLongitude = max(longitude - 0.5, -180.0)
    let minLatitude = max(latitude  - 0.5, -90)
    let maxLongitude = min(longitude + 0.5, 180.0)
    let maxLatitude = min(latitude  + 0.5, 90)
           
    return "\(minLongitude),\(minLatitude),\(maxLongitude),\(maxLatitude)"
       }
    
    enum Endpoint{
        
        static let base  = "https://api.flickr.com/services/rest"
        static let photosPerPage = 25
        
        case getFlickerPhotoSearch(lat: Double, long: Double)
        
        var stringValue: String {
            switch self {
            case .getFlickerPhotoSearch(let lat,let long):
                return Endpoint.base + "?api_key=" + Auth.apiKey + "&format=json&bbox=" + FlickerClient.createBlackBox(withLat: lat, withLong: long) + "&page=\((1...10).randomElement() ?? 1)" + "&nojsoncallback=1&method=flickr.photos.search&extras=url_n&per_page=\(Endpoint.photosPerPage)"
            }
        }
            var url: URL {
                return URL(string: stringValue)!
            }
}
   
   //MARK: - GET Request
   class func taskForGETRequest<T: Decodable>(url: URL, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) -> URLSessionTask {
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data else {
                   DispatchQueue.main.async {
                       completion(nil, error)
                   }
                   return
               }
               let decoder = JSONDecoder()
               do {
                   let responseObject = try decoder.decode(T.self, from: data)
                   
                   DispatchQueue.main.async {
                       completion(responseObject, nil)
                      
                   }
                   
               } catch {
                   
                       DispatchQueue.main.async {
                           completion(nil, error)
                       }
               }
           }
           
           task.resume()
        
           return task
    }
 //MARK: Get Flicker photo search
    class func getFlickerPhotoSearch(latitude: Double,longitude: Double,compeltion: @escaping([String]?,Error?) -> Void){
        
        let url = FlickerClient.Endpoint.getFlickerPhotoSearch(lat: latitude, long: longitude).url
        print("this is request url: \(url)")
        taskForGETRequest(url: url, responseType: PhotosResponse.self) { (response, error) in
            if let response = response {
                var photoURLs = [String]()
                
                response.photos.photo.forEach { (photo) in
                    photoURLs.append(photo.url_n)
                }
                compeltion(photoURLs,nil)
                print(photoURLs)
            }else{
                compeltion(nil,error)
                
            }
        }
        
        
        
    }
    
    
}
