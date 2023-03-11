//
//  NPRequest+Cache.swift
//  FunPlay
//
//  Created by will on 2022/4/12.
//  Copyright © 2022 will. All rights reserved.
//

import UIKit
import Alamofire
extension NPRequest {
    /// 进行数据缓存
    ///
    /// - Parameters:
    ///   - responseJSON: 缓存数据
    ///   - request: 请求
    public func cacheResponse(responseJSON: String,
                                    request: URLRequest){
        let directoryPath: String = NSHomeDirectory() + "/Documents/RequestCaches/"
        ///如果没有目录,那么新建目录
        if !FileManager.default.fileExists(atPath: directoryPath, isDirectory: nil){
            do {
                try FileManager.default.createDirectory(atPath: directoryPath,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            }catch let error {
                print("create cache dir error: " + error.localizedDescription + "\n")
                return
            }
        }
        ///将get请求下的参数拼接到url上
        var absoluterURL = request.description
        if let bodyBase64Str = request.httpBody?.base64EncodedString() {
            absoluterURL += bodyBase64Str
        }
        ///对url进行md5加密
        let key = absoluterURL//.md5()
        ///将加密过的url作为目录拼接到默认路径
        let path = directoryPath.appending(key)
        ///将请求数据转换成data
        let data:Data? = responseJSON.data(using: .utf8)
        
        ///将data存储到指定路径
        if data != nil{
            let isOk = FileManager.default.createFile(atPath: path,
                                                        contents: data,
                                                        attributes: nil)
            if isOk{
                print("cache file ok for request: \(absoluterURL)\n")
                print("key: \(key)\n")
            }else{
                print("cache file error for request: \(absoluterURL)\n")
            }
        }
    }
    
    ///从缓存中获取数据
    public func cahceResponseWithURL(request: URLRequest) -> AFDataResponse<String>? {
        let directorPath = NSHomeDirectory() + "/Documents/RequestCaches/"
        var absoluterURL = request.description
        if let bodyBase64Str = request.httpBody?.base64EncodedString() {
            absoluterURL += bodyBase64Str
        }
        let key = absoluterURL//.md5()
        let path = directorPath.appending(key)
        
        guard let data: Data = FileManager.default.contents(atPath: path) else {
            print("no cache request \(absoluterURL)\n key: \(key)\n")
            return nil
        }
        guard let responseJSON = String(data: data, encoding: .utf8) else {
            print("error cache request \(absoluterURL)\n key: \(key)\n")
            return nil
        }
        let result: AFResult<String> = .success(responseJSON)
        let response = AFDataResponse<String>(request: request, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        return response
    }
}
