//
//  Publisher+AsFuture.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import Foundation
import Combine

/**
 An extension on the `Publisher` protocol providing a convenient way to convert a publisher into a `Future`.
 
 This extension method allows any publisher conforming to the `Publisher` protocol to be transformed into a `Future`. It achieves this by creating a `Future` instance and observing the publisher's events. When the publisher completes with a value, the future succeeds with that value; when it completes with an error, the future fails with that error.
 */
public extension Publisher {
    func asFuture() -> Future<Output, Failure> {
        return Future { promise in
            var ticket: AnyCancellable?
            ticket = self.sink(
                receiveCompletion: {
                    ticket?.cancel()
                    ticket = nil
                    switch $0 {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished: break
                    }
            },
                receiveValue: {
                    ticket?.cancel()
                    ticket = nil
                    promise(.success($0))
            })
        }
    }
}
