//
//  ViewController.swift
//  Neptune
//
//  Created by Benzoudeliuxing on 03/11/2023.
//  Copyright (c) 2023 Benzoudeliuxing. All rights reserved.
//

import UIKit
import Neptune
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var h: Home?
        Neptune.shared.configureEnvironments(dev: NPEnvironment(baseURL: "https://huamulan.hml.shop/"), appStore: NPEnvironment(baseURL: "https://huamulan.hml.shop/"))
        Neptune.shared.unauthorizedHandler
        // When
        HomeC.getHome().onSuccess { home in
            h = home
//            print(h)
        }.onError { error in
//            print(error)
        }
        HomeC.getInfo().onSuccess {
            
        }
    }


}

struct Home: Codable {
    var activitys: [Classify]
}

class Classify: Codable {
    /*
     "id": 770,
     "parentId": 769,
     "depth": 3,
     "categoryName": "食用油",
     "classifyImage": "https://cklcok.oss-cn-zhangjiakou.aliyuncs.com/huamulan/2022-04-11/bfb111f4f39b4fce8f9624153436e58adbd19c339b9a179c.jpg",
     "childs": []
     */
    var id: Int
    var id2: Int?
    var parentId: Int
    var depth: Int
    var categoryName: String
    var classifyImage: String
}
class HomeC {
    static func getHome() -> NPRequest<Home> {
        return NPRequest("huamulanappshop/indexController/getHome").method(.get)
    }
    static func getInfo() -> NPRequest<Nothing> {
        return NPRequest("huamulanappshop/footprint/getAll").method(.get)
    }
}
