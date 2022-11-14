//
//  UIDeviceModel.swift
//  SetUpCameraProgrammatic
//
//  Created by Consultant on 11/13/22.
//

import UIKit

extension UIDevice {
    
    static func getModelName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return mapToDevice(identifier: identifier)
    }
    
    static func getDeviceModel()-> UIDeviceModel? {
        return UIDeviceModel(rawValue: UIDevice.getModelName())
    }
    
    @available(iOS 13.0, *)
    private static func mapToDevice(identifier: String) -> String {
        switch identifier {
        case identifier where identifier.starts(with: "iPhone"):
            return getPhoneModel(from: identifier)
        case identifier where identifier.starts(with: "iPad"):
            return getIpadModel(from: identifier)
        default:
            return identifier
        }
    }
    
    private static func getPhoneModel(from identifier: String) -> String {
            
        switch identifier {
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return UIDeviceModel.iPhone4.rawValue
        case "iPhone4,1":                                     return UIDeviceModel.iPhone4s.rawValue
        case "iPhone5,1", "iPhone5,2":                        return UIDeviceModel.iPhone5.rawValue
        case "iPhone5,3", "iPhone5,4":                        return UIDeviceModel.iPhone5c.rawValue
        case "iPhone6,1", "iPhone6,2":                        return UIDeviceModel.iPhone5s.rawValue
        case "iPhone7,2":                                     return UIDeviceModel.iPhone6.rawValue
        case "iPhone7,1":                                     return UIDeviceModel.iPhone6Plus.rawValue
        case "iPhone8,1":                                     return UIDeviceModel.iPhone6s.rawValue
        case "iPhone8,2":                                     return UIDeviceModel.iPhone6sPlus.rawValue
        case "iPhone9,1", "iPhone9,3":                        return UIDeviceModel.iPhone7.rawValue
        case "iPhone9,2", "iPhone9,4":                        return UIDeviceModel.iPhone7Plus.rawValue
        case "iPhone10,1", "iPhone10,4":                      return UIDeviceModel.iPhone8.rawValue
        case "iPhone10,2", "iPhone10,5":                      return UIDeviceModel.iPhone8Plus.rawValue
        case "iPhone10,3", "iPhone10,6":                      return UIDeviceModel.iPhoneX.rawValue
        case "iPhone11,2":                                    return UIDeviceModel.iPhoneXS.rawValue
        case "iPhone11,4", "iPhone11,6":                      return UIDeviceModel.iPhoneXSMax.rawValue
        case "iPhone11,8":                                    return UIDeviceModel.iPhoneXR.rawValue
        case "iPhone12,1":                                    return UIDeviceModel.iPhone11.rawValue
        case "iPhone12,3":                                    return UIDeviceModel.iPhone11Pro.rawValue
        case "iPhone12,5":                                    return UIDeviceModel.iPhone11ProMax.rawValue
        case "iPhone13,1":                                    return UIDeviceModel.iPhone12mini.rawValue
        case "iPhone13,2":                                    return UIDeviceModel.iPhone12.rawValue
        case "iPhone13,3":                                    return UIDeviceModel.iPhone12Pro.rawValue
        case "iPhone13,4":                                    return UIDeviceModel.iPhone12ProMax.rawValue
        case "iPhone14,4":                                    return UIDeviceModel.iPhone13mini.rawValue
        case "iPhone14,5":                                    return UIDeviceModel.iPhone13.rawValue
        case "iPhone14,2":                                    return UIDeviceModel.iPhone13Pro.rawValue
        case "iPhone14,3":                                    return UIDeviceModel.iPhone13ProMax.rawValue
        case "iPhone14,7":                                    return UIDeviceModel.iPhone14.rawValue
        case "iPhone14,8":                                    return UIDeviceModel.iPhone14Plus.rawValue
        case "iPhone15,2":                                    return UIDeviceModel.iPhone14Pro.rawValue
        case "iPhone15,3":                                    return UIDeviceModel.iPhone14ProMax.rawValue
        case "iPhone8,4":                                     return UIDeviceModel.iPhoneSE.rawValue
        case "iPhone12,8":                                    return UIDeviceModel.iPhoneSE2ndGeneration.rawValue
        case "iPhone14,6":                                    return UIDeviceModel.iPhoneSE3rdGeneration.rawValue
        default:                                              return identifier
        }
    }
    
    
    private static func getIpadModel(from identifier: String) -> String {
            
        switch identifier {
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return UIDeviceModel.iPad2.rawValue
        case "iPad3,1", "iPad3,2", "iPad3,3":                 return UIDeviceModel.iPad3rdGeneration.rawValue
        case "iPad3,4", "iPad3,5", "iPad3,6":                 return UIDeviceModel.iPad4thGeneration.rawValue
        case "iPad6,11", "iPad6,12":                          return UIDeviceModel.iPad5thGeneration.rawValue
        case "iPad7,5", "iPad7,6":                            return UIDeviceModel.iPad6thGeneration.rawValue
        case "iPad7,11", "iPad7,12":                          return UIDeviceModel.iPad7thGeneration.rawValue
        case "iPad11,6", "iPad11,7":                          return UIDeviceModel.iPad8thGeneration.rawValue
        case "iPad12,1", "iPad12,2":                          return UIDeviceModel.iPad9thGeneration.rawValue
        case "iPad13,18", "iPad13,19":                        return UIDeviceModel.iPad10thGeneration.rawValue
        case "iPad4,1", "iPad4,2", "iPad4,3":                 return UIDeviceModel.iPadAir.rawValue
        case "iPad5,3", "iPad5,4":                            return UIDeviceModel.iPadAir2.rawValue
        case "iPad11,3", "iPad11,4":                          return UIDeviceModel.iPadAir3rdGeneration.rawValue
        case "iPad13,1", "iPad13,2":                          return UIDeviceModel.iPadAir4thGeneration.rawValue
        case "iPad13,16", "iPad13,17":                        return UIDeviceModel.iPadAir5thGeneration.rawValue
        case "iPad2,5", "iPad2,6", "iPad2,7":                 return UIDeviceModel.iPadMini.rawValue
        case "iPad4,4", "iPad4,5", "iPad4,6":                 return UIDeviceModel.iPadMini2.rawValue
        case "iPad4,7", "iPad4,8", "iPad4,9":                 return UIDeviceModel.iPadMini3.rawValue
        case "iPad5,1", "iPad5,2":                            return UIDeviceModel.iPadMini4.rawValue
        case "iPad11,1", "iPad11,2":                          return UIDeviceModel.iPadMini5thGneration.rawValue
        case "iPad14,1", "iPad14,2":                          return UIDeviceModel.iPadMini6thGeneration.rawValue
        case "iPad6,3", "iPad6,4":                            return UIDeviceModel.iPadPro9Inch.rawValue
        case "iPad7,3", "iPad7,4":                            return UIDeviceModel.iPadPro10Inch.rawValue
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return UIDeviceModel.iPadPro11Inch1stGeneration.rawValue
        case "iPad8,9", "iPad8,10":                           return UIDeviceModel.iPadPro11Inch2ndGeneration.rawValue
        case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return UIDeviceModel.iPadPro11Inch3rdGeneration.rawValue
        case "iPad14,3", "iPad14,4":                          return UIDeviceModel.iPadPro11Inch4thGeneration.rawValue
        case "iPad6,7", "iPad6,8":                            return UIDeviceModel.iPadPro12Inch1stGeneration.rawValue
        case "iPad7,1", "iPad7,2":                            return UIDeviceModel.iPadPro12Inch2ndGeneration.rawValue
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return UIDeviceModel.iPadPro12Inch3rdGeneration.rawValue
        case "iPad8,11", "iPad8,12":                          return UIDeviceModel.iPadPro12Inch4thGeneration.rawValue
        case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return UIDeviceModel.iPadPro12Inch5thGeneration.rawValue
        case "iPad14,5", "iPad14,6":                          return UIDeviceModel.iPadPro12Inch6thGeneration.rawValue
        default:                                              return identifier
        }
    }
}


