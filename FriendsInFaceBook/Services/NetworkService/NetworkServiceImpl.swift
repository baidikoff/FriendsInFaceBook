//
//  NetworkServiceImpl.swift
//  FriendsInFaceBook
//
//  Created by Oleksa 'trimm' Korin on 12/14/17.
//  Copyright © 2017 Victoria Kravets. All rights reserved.
//

import Foundation

public class NetworkServiceImpl: NetworkService {
    
    // MARK: -
    // MARK: Properties
    
    private let session: URLSession
    
    // MARK: -
    // MARK: Init and Deinit
    
    public init(session: URLSession) {
        self.session = session
    }
    
    // MARK: -
    // MARK: Public
    
    public func data(at url: URL, completion: @escaping (Result<Data, NetworkServiceError>) -> ()) -> NetworkTask {
        let dataTask = self.session.dataTask(with: url) { data, response, error in
            DispatchQueue.global(qos: .background).async {
                completion § Result(
                    value: data,
                    error: error.map(ignoreInput § returnValue § .failed),
                    default: .unknown
                )
            }
        }
        
        dataTask.resume()
        
        return NetworkTask(urlSessionTask: dataTask)
    }
}
