//
//  NetworkStatus.swift
//  FunPlay
//
//  Created by will on 2022/4/12.
//  Copyright © 2022 will. All rights reserved.
//

import UIKit
import Alamofire

typealias NPNetworkStatusBlock = (_ NPNetworkStatus: Int32) -> Void
@objc enum NPNetworkStatus: Int32 {
    case unknown          = -1//未知网络
    case notReachable     = 0//网络无连接
    case cellular             = 1//2，3，4G网络
    case wifi             = 2//wifi网络
}
class NetworkStatus: NSObject {
    static let share = NetworkStatus()
    public var networkStatus: NPNetworkStatus = .wifi
    ///监听网络状态
    public func detectNetwork(netWorkStatus: @escaping NPNetworkStatusBlock) {
        let reachability = NetworkReachabilityManager()
        
        let listener: (NetworkReachabilityManager.NetworkReachabilityStatus) -> Void = { [weak self] status in
            guard let weakSelf = self else { return }
            if reachability?.isReachable ?? false {
                switch status {
                case .notReachable:
                    weakSelf.networkStatus = .notReachable
                case .unknown:
                    weakSelf.networkStatus = .unknown
                case .reachable(.cellular):
                    weakSelf.networkStatus = .cellular
                case .reachable(.ethernetOrWiFi):
                    weakSelf.networkStatus = .wifi
                }
            } else {
                weakSelf.networkStatus = .notReachable
            }
            netWorkStatus(weakSelf.networkStatus.rawValue)
        }
        reachability?.startListening(onUpdatePerforming: listener)
    }
    ///监听网络状态
    public func obtainDataFromLocalWhenNetworkUnconnected() {
        self.detectNetwork { (_) in
        }
    }
}
