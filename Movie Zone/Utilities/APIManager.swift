//
//  APIManager.swift
//  Movie Zone
//
//  Created by Monish Chaudhari on 03/02/23.
//

import Foundation

enum RequestMethod : String {
    case GET
    case POST
    case PUT
    case UPDATE
    case DELETE
}

class APIManager {
    
    static let shared = APIManager()
    
    var session: URLSession = {
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default.copy() as! URLSessionConfiguration
        urlSessionConfiguration.timeoutIntervalForRequest = 60.0
        urlSessionConfiguration.timeoutIntervalForResource = 60.0
        urlSessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
        urlSessionConfiguration.urlCache = nil
        return URLSession(configuration: urlSessionConfiguration)
    }()

    let baseURL = "https://www.omdbapi.com/?apikey=306a33ca"
    
    ///Search all movies using title
    let searchMovies = "&s="
    ///Search single movies using title
    let searchByTitle = "&t="
    ///Search single movies using imdb id
    let searchByIMDBId = "&i="
    
    func makeAPICall(endPoint: String,
                     method: RequestMethod,
                     requestBody: [String:Any]?,
                     HTTPHeaders: [String:String]? = nil,
                     completion: @escaping (Data? ,Error?, URLResponse?) ->()) -> URLSessionDataTask? {
        
        let URLString = (baseURL + endPoint).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        ///Request Type
        var request = URLRequest(url: URL.init(string: URLString!)!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        ///Request Headers
        if let httpHeaders = HTTPHeaders {
            for(key, value) in httpHeaders { request.setValue(value, forHTTPHeaderField: key) }
        }
        
        if let requestBody = requestBody {
            var error: NSError?
            do {
                let body = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                let datastring = NSString(data: body, encoding: String.Encoding.utf8.rawValue)
                print("\(datastring!)")
                request.httpBody = body
            } catch let error1 as NSError {
                error = error1
                print("JSON error: \(String(describing: error))", terminator: "")
            }
        }
        
        ///Sending request to the server.
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil) {
                completion(nil, error, response) }
            
            if (data != nil) {
#if DEBUG
                self.LogAPI(request, responseData: data!, response: response)
#endif
                completion(data, nil, response)
            }
        })
        task.resume()
        return task
    }
    
    private func LogAPI(_ request:URLRequest, responseData:Data?, response:URLResponse?) {
        var logString: String = ""
        logString = logString + "\n\n\n\n\n----------API Call Start----------"
        logString = logString + "\nURL:\n\((request.url)!)"
        if let statusCode = (response as? HTTPURLResponse)?.statusCode{
            logString = logString + "\nStatus Code:\n\(statusCode)"
        }
        if let httpBody = request.httpBody
        {
            logString = logString + "\nRequest JSON:\n\(String(data: httpBody, encoding: String.Encoding.utf8)!)"
        }
        
        logString = logString + "\nRequest Headers:\n\(String(describing: request.allHTTPHeaderFields))"
        if let data = responseData{
            logString = logString + "\nResponse JSON:\n\(String(data: data, encoding: String.Encoding.utf8)!)"
        }
        logString = logString + "\n----------API Call End----------\n\n\n\n\n"
        print(logString)
    }
}
