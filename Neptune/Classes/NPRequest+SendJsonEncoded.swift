//
//  NPRequest+SendJSONEncoded.swift
//  FunPlay
//
//  Created by will on 2021/10/26.
//  Copyright © 2021 will. All rights reserved.
//

import Foundation
import Alamofire

extension NPRequest {
    func sendJsonEncoded() {
        do {
            AF.sessionConfiguration.multipathServiceType = .handover
            
            var params: [String: Any]?
            if let payload = payload {
                params = try payload.dictionary()
            }
            var originalRequest = try URLRequest(url: url, method: method, headers: headers)
            originalRequest.timeoutInterval = responseTimeout
            
            if isEncodedURLRequest {
                let encodedURLRequest = try JSONEncoding.default.encode(originalRequest, with: params)
//                if NetworkStatus.share.networkStatus == .notReachable {
//                    if let cacheResponseJSON = self.cahceResponseWithURL(request: encodedURLRequest) {
//                        self.parseResponse(cacheResponseJSON)
//                        return
//                    }
//                }
                dataRequest = AF.request(encodedURLRequest)
            }else {
                let encodedURLRequest = try URLEncoding.default.encode(originalRequest, with: params)
//                if NetworkStatus.share.networkStatus == .notReachable {
//                    if let cacheResponseJSON = self.cahceResponseWithURL(request: encodedURLRequest) {
//                        self.parseResponse(cacheResponseJSON)
//                        return
//                    }
//                }
                dataRequest = AF.request(encodedURLRequest)
            }
            
            dataRequest?.cacheResponse(using: ResponseCacher.cache)
            dataRequest?.responseString(completionHandler: { responseJSON in
                self.parseResponse(responseJSON)
            })
        } catch {
            log(.error, "请求不正确, sendJsonEncoded URLRequest生成错误!")
        }
    }
}
