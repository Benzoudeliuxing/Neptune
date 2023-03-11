import UIKit

private var _sharedInstance = Neptune()
//token授权错误回调
public typealias UnauthorizedHandler = ()->()
//header 字典类型
public typealias FillHeaders = ()->([String: String])
//header codable类型
public typealias FillCodableHeaders = ()->(Encodable)


open class Neptune {
    public class var shared: Neptune {
        return _sharedInstance
    }
    ///环境配置
    public var environmentMode = EnvironmentMode.auto
    //开发环境
    var _devEnv: NPEnvironment?
    //生产环境
    var _appStoreEnv: NPEnvironment?
    //未授权回调
    public var unauthorizedHandler: UnauthorizedHandler?
    /// 请求超时
    public var responseTimeout: TimeInterval = 30
    /// 追加超时时间
    public var additionalTimeout: TimeInterval = 0
    
    
    public var fillHeaders: FillHeaders?
    public static var fillHeaders: FillHeaders? {
        get {
            return shared.fillHeaders
        }
        set {
            shared.fillHeaders = newValue
        }
    }
    
    public var fillCodableHeaders: FillCodableHeaders?
    public static var fillCodableHeaders: FillCodableHeaders? {
        get {
            return shared.fillCodableHeaders
        }
        set {
            shared.fillCodableHeaders = newValue
        }
    }
    
#if DEBUG
    public var logLevel: LogLevel = .debug
#else
    public var logLevel: LogLevel = .off
#endif
    public var logHandler: LogHandler?
    
    
}
