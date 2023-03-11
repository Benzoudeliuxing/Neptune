//
//  Print+String.swift
//  FunPlay
//
//  Created by will on 2022/4/7.
//  Copyright © 2022 will. All rights reserved.
//

import UIKit

extension String {
    func jsonFormatPrint() -> String {
#if DEBUG
        if (self.starts(with: "{") || self.starts(with: "[")){
            var level = 0
            var jsonFormatString = String()
            
            func getLevelStr(level:Int) -> String {
                var string = ""
                for _ in 0..<level {
                    string.append("\t")
                }
                return string
            }
            
            for char in self {
                
                if level > 0 && "\n" == jsonFormatString.last {
                    jsonFormatString.append(getLevelStr(level: level))
                }
                
                switch char {
                    
                case "{":
                    fallthrough
                case "[":
                    level += 1
                    jsonFormatString.append(char)
                    jsonFormatString.append("\n")
                case ",":
                    jsonFormatString.append(char)
                    jsonFormatString.append("\n")
                case "}":
                    fallthrough
                case "]":
                    level -= 1;
                    if level >= 0 {
                        jsonFormatString.append("\n")
                        jsonFormatString.append(getLevelStr(level: level));
                        jsonFormatString.append(char);
                    }
                    break;
                default:
                    jsonFormatString.append(char)
                }
            }
            return jsonFormatString;
        }
        
        return self
#else
        return self
#endif
        
    }
}
