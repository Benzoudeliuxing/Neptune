//
//  File.swift
//  
//
//  Created by will on 2023/3/5.
//

import Foundation
import Alamofire
extension NPRequest {
    var host: String {
        return tempHost ?? Neptune.shared.apiURL
    }
    
    var url: String {
        var url = host + "/" + endpoint
        if query.raw.count > 0 {
            if url.contains("?") {
                url.append("&")
            } else {
                url.append("?")
            }
            url.append(query.raw)
        }
        return url
    }
    
    @discardableResult
    public func method(_ method: HTTPMethod) -> NPRequest {
        self.method = method
        return self
    }
    
    @discardableResult
    public func isEncodedURLRequest(_ isEncodedURLRequest: Bool) -> NPRequest {
        self.isEncodedURLRequest = isEncodedURLRequest
        return self
    }
    
    @discardableResult
    public func showLoading(_ showLoading: Bool) -> NPRequest {
        self.showLoading = showLoading
        return self
    }
    
    @discardableResult
    public func loadingText(_ loadingText: String) -> NPRequest {
        self.loadingText = loadingText
        return self
    }
    
    @discardableResult
    public func addCache() -> NPRequest {
        self.needCache = true
        return self
    }
    
    @discardableResult
    public func payload(_ payload: PayloadProtocol) -> NPRequest {
        self.payload = payload
        return self
    }
    
    @discardableResult
    public func query(_ params: Codable) -> NPRequest {
        self.query.codable = params
        self.query.raw = buildURLEncodedString(from: params) ?? ""
        return self
    }
    
    @discardableResult
    public func headers(_ headers: [String: String]) -> NPRequest {
        for (key, value) in headers {
            self.headers[key] = value
        }
        return self
    }
    
    @discardableResult
    public func multipartFormDataCallback(_ callback: @escaping (MultipartFormData) -> Void) -> NPRequest {
        multipartFormDataCallback = callback
        return self
    }
    
    @discardableResult
    public func responseTimeout(_ interval: TimeInterval) -> NPRequest {
        responseTimeout = interval
        return self
    }
    
    
    @discardableResult
    public func onSuccess(_ start: Bool = true, _ callback: @escaping SuccessResponse) -> NPRequest {
        successCallback = callback
        if start { self.start() }
        return self
    }
    
    @discardableResult
    public func onSuccess(_ start: Bool = true, _ callback: @escaping (()->())) -> NPRequest {
        emptySuccessCallback = callback
        if start { self.start() }
        return self
    }
    
    @discardableResult
    public func onError(_ callback: @escaping ErrorResponse) -> NPRequest {
        errorCallback = callback
        return self
    }
    
    @discardableResult
    public func onNotAuthorized(_ callback: @escaping NotAuthorizedResponse) -> NPRequest {
        notAuthorizedCallback = callback
        return self
    }
    
    @discardableResult
    public func onProgress(_ callback: @escaping (Double)->()) -> NPRequest {
        progressCallback = callback
        return self
    }
}
