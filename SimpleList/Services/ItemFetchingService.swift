//
//  ItemFetchingService.swift
//  SimpleList
//
//  Created by shimanopower on 9/18/20.
//  Copyright © 2020 shimanopower. All rights reserved.
//

import Foundation

class ItemFetchingService {
    typealias ItemDataCompletionHandler = ([ItemData]?, ErrorType?) -> ()
    private static let host = "fetch-hiring.s3.amazonaws.com"
    private static let path = "/hiring.json"
    
//    https://fetch-hiring.s3.amazonaws.com/hiring.json
    
    static func fetchItems(with completion: @escaping ItemDataCompletionHandler) {
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = path
        
        let url = urlBuilder.url!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Request failed: \(error!.localizedDescription)")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No data returned from endpoint")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable to process response")
                    completion(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failure with HTTP status code: \(response.statusCode)")
                    completion(nil, .failedRequest)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let itemData = try decoder.decode([ItemData].self, from: data)
                    completion(itemData, nil)
                } catch {
                    print("Unable to decode response: \(error.localizedDescription)")
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
