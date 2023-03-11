//
//  File.swift
//  
//
//  Created by will on 2023/3/5.
//

import Foundation

extension Neptune {
    
    public func configureEnvironments(dev: NPEnvironment, appStore: NPEnvironment) {
        _devEnv = dev
        _appStoreEnv = appStore
    }
    
    public var env: NPEnvironment {
        var env: NPEnvironment?
        switch environmentMode {
        case .dev: env = _devEnv
        case .appStore: env = _appStoreEnv
        }
        if let env = env {
            return env
        } else {
            assert(false, "Unable to get env url for \(environmentMode) cause it's nil")
            return NPEnvironment(baseURL: "")
        }
    }
    
    public var apiURL: String {
        return env.apiURL
    }
}
