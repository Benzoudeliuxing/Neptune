//
//  File.swift
//  
//
//  Created by will on 2023/3/3.
//

import Foundation
///请求错误
public struct NetworkError {
    fileprivate var _code: StatusCode?
    fileprivate var _message: String?
    
    static let noNetwork = NetworkError(code: .noNetwork, message: "没有网络连接，请稍后重试")
    static let unauthorized = NetworkError(code: .unauthorized)
    
    public var message: String?{
        get{
            return self._message
        }
    }
    public var code: StatusCode?{
        get{
            return self._code
        }
    }
    
    public init(code: StatusCode?) {
        self._code = code
        self._message = ""
    }
    public init(code: StatusCode?,message: String?){
        self._code = code
        self._message = message
    }
}

func == (left: NetworkError, right: NetworkError) -> Bool {
    return (left._code == right._code)
}
func != (left: NetworkError, right: NetworkError) -> Bool {
    return !(left == right)
}
