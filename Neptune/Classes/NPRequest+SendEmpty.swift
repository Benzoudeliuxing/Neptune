//
//  File.swift
//  
//
//  Created by will on 2023/3/5.
//

import Foundation
import Alamofire
extension NPRequest {
    func sendEmpty() {
        do {
            AF.sessionConfiguration.multipathServiceType = .handover
            
            var originalRequest = try URLRequest(url: url, method: method, headers: headers)
            originalRequest.timeoutInterval = responseTimeout
            
            log(.info, "[--request------------------------------]")
            
            dataRequest = AF.request(originalRequest)
            dataRequest?.cacheResponse(using: ResponseCacher.cache)
            dataRequest?.responseString(completionHandler: { responseJSON in
                self.parseResponse(responseJSON)
            })
            
        } catch {
            log(.error, "请求不正确, sendEmpty URLRequest生成错误!")
            //请求不正确
        }
    }
}

