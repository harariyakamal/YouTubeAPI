//
//  NetworkManager.swift
//  YouTube
//
//  Created by Kamal Harariya on 3/16/18.
//  Copyright © 2018 company. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    case error
    case noData
    case wrongInputs
    case noError
    case wrongOutput
    case wrongUrl
}

typealias ImageDownloadingCompletionHandler = (_ imageData: Data?, _ error: NetworkError) -> ()
private let urlSession = URLSession(configuration: .ephemeral)

class NetworkManager {
    
    /// An instance of `Networkmanager` class.
    private static var _commonInstance: NetworkManager!
    
    /**
     +shared returns a common instance of NetworkManager.
     */
    class var shared: NetworkManager {
        get {
            if _commonInstance == nil {
                _commonInstance = NetworkManager()
            }
            
            return _commonInstance
        }
    }
    
    // An array that will hold all the work items for image downloading.
    private var imageDownloadWorkItems = [DispatchWorkItem]()
    
    func getdataFrom(urlString serviceUrl: String, withHandler completionHandler: @escaping (_ response: Dictionary<String, Any>?, _ error: NetworkError) -> ()) {
        
        let url = URL(string: serviceUrl)
        
        guard let requestUrl = url else {
            completionHandler(nil, .wrongInputs)
            return
        }
        
        let urlRequest = URLRequest(url: requestUrl)
        
        // Make request (can call with url direct but in case I need to speocify properties like cache policy and all. )
        let task = urlSession.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // Check of error, if its not nil, response with execute completion.
            if let _ = error {
                completionHandler(nil, .error)
            }
            
            // Check for response, if thats nil then call completion block.
            guard let responseData = data else {
                completionHandler(nil, .noData)
                return
            }
            
            // parse the result as JSON
            do {
                guard let parsedResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? Dictionary<String, Any> else {
                    completionHandler(nil, .wrongOutput)
                    return
                }
                completionHandler(parsedResponse, .noError)
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, .error)
                return
            }
        })
        task.resume()
    }
    
    // We can use the same method as above, this is just the another way of getting response from an server.
    func downloadImage(fromUrl urlString: String?, withHandler completionHandler: @escaping ImageDownloadingCompletionHandler) {
        
        guard let _urlString = urlString else {
            completionHandler(nil, .wrongUrl)
            return
        }
        
        let downloadBlock = DispatchWorkItem(flags: .inheritQoS) {
            guard let _url = URL(string: _urlString) else {
                completionHandler(nil, .wrongUrl)
                return
            }
            
            let task = urlSession.dataTask(with: _url, completionHandler: {
                data, response, error in
                // Should handle all the error types here. (Checking only 1 condition here)
                if error != nil {
                    completionHandler(nil, .error)
                } else {
                    completionHandler(data, .noError)
                }
            })
            task.resume()
        }
        
        imageDownloadWorkItems.append(downloadBlock)
        DispatchQueue.main.async(execute: downloadBlock)
    }
    
    // TODO: Write a function that will cancel the image download operation those are not yet started. (When the user has scrolled up or down and if there is any image request for those cells, that should be cancelled. )
}
