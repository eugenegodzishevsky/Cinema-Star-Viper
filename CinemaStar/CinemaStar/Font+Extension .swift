// Font+Extension .swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIFont {
    static var fontsMap: [String: UIFont] = [:]

    class func inter(ofSize fontSize: CGFloat) -> UIFont {
        searchFont(name: "Inter-Regular", fontSize: fontSize)
    }

    class func interBold(ofSize fontSize: CGFloat) -> UIFont {
        searchFont(name: "Inter-Bold", fontSize: fontSize)
    }

    class func interMedium(ofSize fontSize: CGFloat) -> UIFont {
        searchFont(name: "Inter-Medium", fontSize: fontSize)
    }

    private class func searchFont(name: String, fontSize: CGFloat) -> UIFont {
        let key = "\(name)\(fontSize)"
        if let font = fontsMap[key] {
            return font
        }

        let font = UIFont(name: name, size: fontSize) ?? UIFont()
        fontsMap[key] = font
        return font
    }
}
