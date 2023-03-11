//
//  File.swift
//  
//
//  Created by will on 2023/3/3.
//

import Foundation
import Alamofire

public protocol PayloadProtocol: Codable {}
public protocol MultipartPayload: PayloadProtocol {}

public protocol AnyAPIRequest {
    var cancelled: Bool { get }
    func cancel()
}

public class NPRequest<T: Codable>: AnyAPIRequest {
    
    public typealias SuccessResponse = (T)->()
    public typealias SuccessEmptyResponse = ()->()
    public typealias ErrorResponse = (NetworkError)->()
    public typealias Progress = (Double)->()
    public typealias NotAuthorizedResponse = ()->()
    
    var tempHost: String? ///临时域名，针对外链接
    var endpoint: String = "/"
    var headers: HTTPHeaders = Neptune.shared.globalHeaders
    var successStatusCodes: [StatusCode] = [.ok]
    var method: HTTPMethod = .get
    var payload: PayloadProtocol?
    
    var isEncodedURLRequest: Bool = true
    var needCache: Bool = false
    var query = QueryContainer()
    var showLoading:Bool = false
    var loadingText:String?
    ///请求超时时间
    var responseTimeout: TimeInterval = Neptune.shared.responseTimeout
    /// 请求
    var dataRequest: DataRequest?
    ///上传数据处理回调
    var multipartFormDataCallback: ((MultipartFormData) -> ())?
    ///成功回调
    public var successCallback: SuccessResponse?
    ///空白成功
    public var emptySuccessCallback: SuccessEmptyResponse?
    ///失败回调
    public var errorCallback: ErrorResponse?
    ///进度回调
    public var progressCallback: Progress?
    ///未授权回调
    public var notAuthorizedCallback: NotAuthorizedResponse?
    
    
    public init(_ endpoint: String..., payload: PayloadProtocol? = nil) {
        self.endpoint = endpoint.joined(separator: "/")
        self.payload = payload
    }
    
    public init(host: String, endpoint: String..., payload: PayloadProtocol? = nil) {
        self.tempHost = host
        self.endpoint = endpoint.joined(separator: "/")
        self.payload = payload
    }
    
    public func start() {
        logRequestStarted()
        if payload == nil {
            sendEmpty()
        }else if let _ = payload as? MultipartPayload {
            sendMultipartEncoded()
        }else {
            sendJsonEncoded()
        }
    }
    
    private func logRequestStarted() {
        log(.info, "\(method.rawValue.uppercased()) to \(url)")
//        requestStartedCallback?()
        if let payload = payload {
            log(.debug, "payload: \(String(describing: payload))")
        } else {
            log(.debug, "payload: nil")
        }
        log(.debug, "headers: \(headers)")
    }
    
    public var cancelled: Bool = false
    
    public func cancel() {
        
    }
    
    
}
