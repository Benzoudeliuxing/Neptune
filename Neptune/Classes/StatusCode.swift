//
//  File.swift
//  
//
//  Created by will on 2023/3/3.
//

import Foundation

@available(*, deprecated, renamed: "StatusCode")

public typealias HTTPStatusCode = StatusCode
//常见请求状态码
public enum StatusCode {
    case noNetwork
    //MARK: 2xx
    case ok
    case created
    
    //MARK: 4xx
    case unauthorized
    case overauthorized
    case forbidden
    case notFound
    //MARK: Unknown
    case unknown(String)
    
    public var raw: String {
        switch self {
            case .noNetwork: return "13"
            //MARK: 2xx
            case .ok: return "200"
            case .created: return "201"
            
            //MARK: 4xx
            case .unauthorized: return "401"
            case .overauthorized: return "20004"
            case .forbidden: return "403"
            case .notFound: return "404"
            
            //MARK: Unknown
            case .unknown(let v): return v
        }
    }
    
    static func from(raw: String) -> StatusCode {
        switch raw {
            case "13": return .noNetwork
            //MARK: 2xx
            case "200": return .ok
            case "201": return .created
            
            //MARK: 4xx
            case "401": return .unauthorized
            case "20004": return .overauthorized
            case "403": return .forbidden
            case "404": return .notFound
        default:
            return .unknown(raw)
        }
    }
}
extension StatusCode: Equatable {
    public static func == (lhs: StatusCode, rhs: StatusCode) -> Bool {
        return lhs.raw == rhs.raw
    }
}
