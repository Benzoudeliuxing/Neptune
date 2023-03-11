//
//  File.swift
//  
//
//  Created by will on 2023/3/5.
//

import Foundation

/// 基础返回数据
public struct ResultModel<DataType: Codable>: Codable {
    
    var message: String
    
    var code: String
    
    var data: DataType?
    
}

/// 没有返回
public struct Nothing: Codable {}

/// 翻页数据
public struct PageResult<T: Codable>: Codable {
    
    public var list: [T] = [T]()
    
//    public var total: Int
}
