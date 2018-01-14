//
//  Networking.swift
//  TestWeatherApp
//
//  Created by Javid Sheikh on 13/01/2018.
//  Copyright © 2018 Javid Sheikh. All rights reserved.
//

import Foundation
import Alamofire

class NetworkRequestHelper {
    
    public func fetchWeatherJSONData(for location: String, errorHandler: @escaping ()-> Void, handler: @escaping (Dictionary<String, Any>) -> Void)  {
        Alamofire.request("http://api.openweathermap.org/data/2.5/forecast?q=" + location + "&appid=1be90bc9c2b4848aa703ae05ed5e5c8e").validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let json = response.result.value as? Dictionary<String, AnyObject> else {
                    return
                }
                handler(json)
            case.failure(let error):
                print(error)
                errorHandler()
            }
        }
    }
    
    public func fetchWeatherIcon(withCode code: String, handler: @escaping (Data) -> Void) {
        Alamofire.request("http://openweathermap.org/img/w/" + code + ".png").responseData {response in
            guard let data = response.data else {
                return
            }
            handler(data)
        }
    }
}
