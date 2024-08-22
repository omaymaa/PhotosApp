//
//  RemoteApi.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation
import Alamofire
import Combine

public protocol RemoteAPI {
    func request<T: Codable>(endPoint: String, method: HTTPMethod, parameters: Parameters? ) -> Future<T, ErrorMessage>
}
extension RemoteAPI {
    public func request<T: Codable>(endPoint: String, method: HTTPMethod, parameters: Parameters?) -> Future<T, ErrorMessage> {
        let baseUrl = "https://jsonplaceholder.typicode.com/"
                
        return Future { promise in
            AF.request("\(baseUrl)\(endPoint)", method: method, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let resultObject):
                    promise(.success(resultObject))
                case .failure(let error):
                    promise(.failure(ErrorMessage(error: error)))
                }
            }
        }
    }
}
