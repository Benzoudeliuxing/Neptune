//
//  NPRequest+PareResponse.swift
//  FunPlay
//
//  Created by will on 2021/10/25.
//  Copyright © 2021 will. All rights reserved.
//

import Foundation
import Alamofire

extension NPRequest {
    func parseResponse(_ answer: AFDataResponse<String>) {
        //print log
        log(.info, "[--response------------------------------]")
        log(.info, answer.request == nil ? "" : answer.request!.description)
        log(.info, "payload: \(String(describing: payload))")
        
        switch(answer.result){
        case .success(let value) :
            log(.info, value.jsonFormatPrint())
            log(.info, "[--end--------------------------------]")
            guard let data = value.data(using: .utf8) else {
                self.parseError("0", nil, nil, "请求失败")
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedResult = try decoder.decode(ResultModel<T>.self, from: data)
                if let decodedResultData = decodedResult.data {
                    if successStatusCodes.map({$0.raw}).contains(decodedResult.code) {
                        self.successCallback?(decodedResultData)
                        self.emptySuccessCallback?()
                    }
                }else if decodedResult.code == StatusCode.unauthorized.raw || decodedResult.code == StatusCode.overauthorized.raw {
                    Neptune.shared.unauthorizedHandler?()
                    self.notAuthorizedCallback?()
                    return
                }else {
                    self.parseError(decodedResult.code, nil, nil, decodedResult.message)
                }
            } catch {
                self.parseError("0", nil, nil, "请求失败")
            }
        case .failure(let error):
            log(.error, "请求失败，原因：")
            log(.error, "\(String(describing: answer.error?.errorDescription ?? ""))")
            log(.error, "\(String(describing: answer.debugDescription))")
            log(.error, "[--end--------------------------------]")
            self.parseError("\(error._code)", error, nil, "请求失败")
        }
    }

    
    private func wrap(_ obj: AnyObject?,defaultValue: String) -> String {
        if obj == nil {
            return defaultValue
        }
        if obj!.isKind(of: NSString.classForCoder()) {
            return obj as! String
        }
        return "\(obj!)"
    }
}
