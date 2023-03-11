//
//  File.swift
//  
//
//  Created by will on 2023/3/3.
//

import Foundation

public struct NPEnvironment {
    private var _apiURL: ServerURL?
    //设置环境地址
    public init(baseURL: String, path: String? = nil) {
        _apiURL = ServerURL(base: baseURL, path: path)
    }
    //get域名
    public var apiBaseURL: String {
        guard let _apiURL = _apiURL else {
            assert(false, "未设置地址")
            return ""
        }
        return _apiURL.base
    }
    //get环境地址
    public var apiURL: String {
        guard let _apiURL = _apiURL else {
            assert(false, "未设置地址")
            return ""
        }
        return _apiURL.fullURL
    }
}

///服务器地址类
public struct ServerURL {
    public var base: String
    public var path: String?
    public init (base: String, path: String? = nil) {
        self.base = base
        self.path = path
    }
    
    public var fullURL: String {
        var fullURL = base
        if let path = path, path.count > 0 {
            fullURL = fullURL + "/" + path
        }
        return fullURL
    }
}
