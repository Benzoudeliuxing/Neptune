//
//  NeptuneError.swift
//  FunPlay
//
//  Created by will on 2021/10/27.
//  Copyright © 2021 will. All rights reserved.
//

import Foundation

protocol NeptuneErrorProtocol: LocalizedError {
    var title: String { get }
}

struct NeptuneError: NeptuneErrorProtocol {
    var title: String
    init(_ title: String) {
        self.title = title
    }
}
