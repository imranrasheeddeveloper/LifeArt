//
//  MyAPIClient.swift
//  LifeArt
//
//  Created by Muhammad Imran on 28/04/2021.
//  Copyright © 2021 Itrid Technologies. All rights reserved.
//

import Foundation
import Stripe

class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider {
    enum APIError: Error {
        case unknown

        var localizedDescription: String {
            switch self {
            case .unknown:
                return "Unknown error"
            }
        }
    }

    static let sharedClient = MyAPIClient()
    var baseURLString: String?
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
    }


    func createCustomerKey(
        withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock
    ) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [URLQueryItem(name: "api_version", value: apiVersion)]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                guard let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = data,
                    let json =
                        ((try? JSONSerialization.jsonObject(with: data, options: [])
                        as? [String: Any]) as [String: Any]??)
                else {
                    completion(nil, error)
                    return
                }
                completion(json, nil)
            })
        task.resume()
    }

}
