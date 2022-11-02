//
//  NetworkService.swift
//  PhotosLibrary
//
//  Created by Oleksandr Khalypa on 29.10.2022.
//

import Foundation

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID dc1bcc94279ed5b3be81b9f5b7188d01565f5e9eefad81f9fb9b805daf5dec30"
        return headers
    }
    
    private func createDataTask(from requst: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
