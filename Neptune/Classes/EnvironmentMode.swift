//
//  File.swift
//  
//
//  Created by will on 2023/3/3.
//

import Foundation
//环境配置
public enum EnvironmentMode: String {
    case dev, appStore
    
    /// 自动DEBUG 配置dev环境
    static var auto: EnvironmentMode {
        #if DEBUG
        return .dev
        #else
        return .appStore
        #endif
    }
}
