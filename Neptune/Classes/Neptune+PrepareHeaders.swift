//
//  File.swift
//  
//
//  Created by will on 2023/3/3.
//

import Foundation
import Alamofire
extension Neptune {
    ///全局header
    var globalHeaders: HTTPHeaders {
        let headersDic = fillHeaders?() ?? [:]
        return HTTPHeaders(headersDic)
    }
    
}
