//
//  NetworkManager+Rx.swift
//  ERDNetwork
//
//  Created by Erdi Tunçalp on 29.06.2021.
//

#if canImport(RxSwift)
import RxSwift
import RxCocoa

extension NetworkManager {
    
    public func execute<T: Endpoint>(request: T) -> Observable<T.Response> {
        guard let request = try? request.asURLRequest() else {
            return Observable.error(NetworkingError.parameterEncodingFailed(reason: .missingURL))
        }

        return Observable<T.Response>.create { observer in
            let response = URLSession.shared.rx.response(request: request)
                                  .debug("test api request")

            return response.subscribe(onNext: { response, data in
                
                if self.isLogEnabled {
                    print("Response: \(data.prettyPrint) - Status Code: \(response.httpStatusCode)")
                }
                
                guard 200..<300 ~= response.statusCode else {
                    return observer.onError(NetworkingError.connectionError(response.filterStatusCode(with: data)))
                }
                
                guard let responseItems = try? JSONDecoder().decode(T.Response.self, from: data) else {
                    return observer.onError(NetworkingError.undefined)
                }
                
                observer.onNext(responseItems)
                observer.onCompleted()
                
            }, onError: { error in
                observer.onError(NetworkingError.undefined)
            })
        }
    }
    
}

#endif
