//
//
//  Created by Emad Habib on 15/7/2025.
//

import Foundation
import Alamofire

final class APIRequestInterceptor: RequestInterceptor {

    private let token: String
    // MARK: Init
    init(token: String) {
        self.token = token
    }
    
    func adapt(_ urlRequest: URLRequest, for _: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if !token.isEmpty {
            urlRequest.headers.add(.authorization(bearerToken: token))
        }
        completion(.success(urlRequest))
    }
}
