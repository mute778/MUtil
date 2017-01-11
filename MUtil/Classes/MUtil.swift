//
//  MUtil.swift
//  Pods
//
//  Created by mute778 on 2016/12/26.
//
//

import UIKit

@objc public class MUtil: NSObject {
    
    public enum CheckVersionTarget {
        case OSVersion
        case AppVersion
        case BuildVersion
    }
    
    // =============================================================================
    // MARK: - PublicMethod
    // =============================================================================
    
    /**
     ログを出力する
     - parameter message: 出力文字列
     - parameter file: ファイル名(省略)
     - parameter function: メソッド名(省略)
     - parameter line: 行番号(省略)
     */
    public class func log(
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
    public class func getOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    /**
     アプリバージョン文字列を取得する
     - returns: String アプリバージョン文字列
     */
    public class func getAppVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /**
     アプリのビルドバージョン文字列を取得する
     - returns: String ビルドバージョン文字列
     */
    public class func getBuildVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
    
    /**
     ベンダーIDを取得する
     - returns: String ベンダーID
     */
    public class func getVendorId() -> String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    /**
     画面サイズを取得する
     - returns: CGSize 画面サイズ
     */
    public class func getScreenBounds() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    /**
     現在のアプリバージョンが指定範囲内であるか確認する
     - parameter min: 範囲最小バージョン
     - parameter max: 範囲最大バージョン
     - return: Bool YES:範囲内, NO:範囲外
     */
    public class func checkVersionRange(target: CheckVersionTarget, min: String, max: String) -> Bool {
        var currentVersion: String
        
        switch target {
        case .OSVersion:
            currentVersion = self.getOsVersion()
        case .AppVersion:
            currentVersion = self.getAppVersion()
        case .BuildVersion:
            currentVersion = self.getBuildVersion()
        default:
            return false
        }
        
        let minResult = min.compare(currentVersion, options: .numeric)
        let maxResult = max.compare(currentVersion, options: .numeric)
        
        if ( (minResult == .orderedAscending || minResult == .orderedSame) && (maxResult == .orderedSame || maxResult == .orderedDescending) ) {
            return true
        }
        
        return false
    }
    
    /**
     ローカライズファイルから文字列を取得する
     */
    public class func getLocalizedString(_ key: String) -> String {
        return NSLocalizedString(key, comment: "");
    }
    
    /**
     グレゴリオ暦形式で日付文字列を返却する
     - parameter date: 変換対象日付
     - paremeter format: 出力形式フォーマット
     */
    public class func getGregorianDateString(date: Date, format: String) -> String {
        
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
    public class func canOpenURL(_ url: String) -> Bool {
        return UIApplication.shared.canOpenURL(URL(string: url)!)
    }
    
    /**
     指定URLを開く
     - parameter url: 指定URL文字列
     - returns: Bool YES:開くことができた場合, NO:開くことができなかった場合
     */
    public class func openURL(_ url: String) -> Bool {
        if ( canOpenURL(url) ) {
            // 指定URLを開くことができる場合
            
            // 指定URLを開く
            UIApplication.shared.openURL(URL(string: url)!)
            return true
        }
        
        return false
    }
    
    /**
     文字列がアプリで設定されているスキームであるか確認する
     - parameter scheme: String 確認対象文字列
     - returns: Bool YES:設定されている, NO:設定されていない
     */
    public class func isAppScheme(_ scheme: String) -> Bool {
        let util = MUtil()
        let schemeList: Array<String> = util.getAppSchemeList()
        
        for settingScheme: String in schemeList {
            if ( settingScheme == scheme ) {
                return true
            }
        }
        
        return false
    }
    
    /**
     指定文字列をエンコードする
     - parameter url: String エンコード対象文字列
     - returns: String エンコード後文字列
     */
    public class func encodeUrlString(_ url: String) -> String {
        return url.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
    }
    
    /**
     指定文字列をデコードする
     - parameter url: String デコード対象文字列
     - returns: String デコード後文字列
     */
    public class func decodeUrlString(_ url: String) -> String {
        return url.removingPercentEncoding!
    }
    
    /**
     ラベルの高さを取得する
     - parameter label: 表示するUILabel
     - returns: CGFloat ラベルの高さ
     */
    public class func getLabelHeight(label: UILabel) -> CGFloat {
        let attrString = NSAttributedString.init(string: label.text!,
                                                 attributes: [NSFontAttributeName:label.font])
        let rect = attrString.boundingRect(with: CGSize(width: label.frame.size.width,
                                                        height: CGFloat.greatestFiniteMagnitude),
                                           options: .usesLineFragmentOrigin,
                                           context: nil)
        return rect.height
    }
    
    /**
     アプリアイコンにバッジを設定する
     - parameter badgeNumber: 設定数値(0の場合は削除)
     */
    public class func setAppBadge(_ badgeNum: Int) -> Void {
        UIApplication.shared.applicationIconBadgeNumber = badgeNum
    }
    
    // =============================================================================
    // MARK: - PrivateMethod
    // =============================================================================
    
    /**
     設定されているアプリのスキームを全て取得する
     - returns: Array<String>
     */
    private func getAppSchemeList() -> Array<String> {
        
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
}
