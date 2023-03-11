//
//  NPRequest+SendMultipart.swift
//  FunPlay
//
//  Created by will on 2021/12/10.
//  Copyright © 2021 will. All rights reserved.
//

import Foundation
import Alamofire

extension NPRequest {
    ///上传数据
    func sendMultipartEncoded() {
        AF.sessionConfiguration.multipathServiceType = .handover
        dataRequest = AF.upload(multipartFormData: { (multipartFormData) in
            self.multipartFormDataCallback?(multipartFormData)
        }, to: url, method: method, headers: headers).uploadProgress(closure: { progress in
            self.progressCallback?(progress.fractionCompleted)
        })
        dataRequest?.responseString(completionHandler: { responseJSON in
            self.parseResponse(responseJSON)
        })
    }
}
