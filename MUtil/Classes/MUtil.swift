//
//  MUtil.swift
//  Pods
//
//  Created by 宮田　寿康 on 2016/12/26.
//
//

import UIKit

class MUtil: NSObject {
    
    /**
     ログを出力する
     - parameter message: 出力文字列
     - parameter file: ファイル名(省略)
     - parameter function: メソッド名(省略)
     - parameter line: 行番号(省略)
     */
    class func log(
        _ message: String,
        file: String = #file,
        function: String = #function,
        line: Int = #line
        ) -> Void {
        
        let filePath = file.components(separatedBy: "/");
        let fileName = filePath.last!.components(separatedBy: ".")
        
        let dateStr = self.getGregorianDateString(date: Date(), format: "yyyy-MM-dd HH:mm:ss.sss")
        
        
        #if DLOG
            print("\(dateStr) [\(fileName.first!) \(function) - \(line)]\n\(message)")
        #else
            // 出力しない
        #endif
    }
    
    /**
     OSバージョン文字列を取得する
     - returns: String OSバージョン
     */
    class func getOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /**
     アプリバージョン文字列を取得する
     - returns: String アプリバージョン文字列
     */
    class func getAppVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /**
     アプリのビルドバージョン文字列を取得する
     - returns: String ビルドバージョン文字列
     */
    class func getBuildVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    /**
     ローカライズファイルから文字列を取得する
     */
    class func getLocalizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "");
    }
    
    /**
     グレゴリオ暦形式で日付文字列を返却する
     - parameter date: 変換対象日付
     - paremeter format: 出力形式フォーマット
     */
    class func getGregorianDateString(date: Date, format: String) -> String {
        
        // DateFormatter設定
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        
        // カレンダーをグレゴリオ暦に指定
        let calendar = Calendar(identifier: .gregorian)
        
        // DateFormatterに暦をセット
        dateFormat.calendar = calendar
        
        return dateFormat.string(from: date)
    }
    
    /**
     指定URLを開くことができるか確認する
     - parameter url: 指定URL文字列
     - returns: Bool YES:開くことができる, NO:開くことができない
     */
    class func canOpenURL(_ url: String) -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: url)!)
    }
    
    /**
     指定URLを開く
     - parameter url: 指定URL文字列
     - returns: Bool YES:開くことができた場合, NO:開くことができなかった場合
     */
    class func openURL(_ url: String) -> Bool {
        if ( canOpenURL(url) ) {
            // 指定URLを開くことができる場合
            
            // 指定URLを開く
            UIApplication.shared.openURL(URL(string: url)!)
            return true
        }
        
        return false
    }
    
    /**
     設定されているアプリのスキームを全て取得する
     - returns: Array<String>
     */
    class func getAppSchemeList() -> Array<String> {
        
        var result: Array<String> = []
        
        let bundleUrlTypes = Bundle.main.infoDictionary?["CFBundleURLTypes"]
        
        if ( bundleUrlTypes != nil ) {
            let bundleUrlTypesArray = bundleUrlTypes as! NSArray
            for bundleUrlType in bundleUrlTypesArray {
                let urlSchemes = (bundleUrlType as! NSDictionary)["CFBundleURLSchemes"]
                if ( urlSchemes != nil ) {
                    let schemeStr: String = (urlSchemes as! NSArray)[0] as! String
                    result.append(schemeStr)
                }
            }
        }
        
        return result
    }
    
    /**
     文字列がアプリで設定されているスキームであるか確認する
     - parameter scheme: String 確認対象文字列
     - returns: Bool YES:設定されている, NO:設定されていない
     */
    class func isAppScheme(_ scheme: String) -> Bool {
        let schemeList: Array<String> = getAppSchemeList()
        
        for settingScheme: String in schemeList {
            if ( settingScheme == scheme ) {
                return true
            }
        }
        
        return false
    }
}
