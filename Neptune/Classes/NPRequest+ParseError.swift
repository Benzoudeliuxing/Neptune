//
//  APIRequest+ParseError.swift
//  FunPlay
//
//  Created by will on 2021/10/27.
//  Copyright © 2021 will. All rights reserved.
//

import Foundation
import Alamofire

extension NPRequest {
    func parseError(_ statusCode: String, _ error: Error?, _ data: Data?, _ description: String) {
        var state = NetworkError(code: StatusCode.from(raw: statusCode), message:error?.localizedDescription ?? description)
        //登录过期
        if state == .unauthorized {
            Neptune.shared.unauthorizedHandler?()
            self.notAuthorizedCallback?()
        }else {
            //无网络
            if state == .noNetwork {
                state = .noNetwork
            }
            self.errorCallback?(state)
        }
    }
}
