//
//  StyleController.swift
//  StarWarsfans
//
//  Created by Angela Velilla Aguirre on 21/08/2018.
//  Copyright © 2018 Angela Velilla Aguirre. All rights reserved.
//

import UIKit

class StyleController: NSObject {

    //MARK: colors
    class func mainYellowColor () -> UIColor {
        return UIColor (red: 251.0/255.0, green: 227.0/255.0, blue: 76.0/255.0, alpha: 1.0)
    }
    
    class func blackColor() -> UIColor {
        return UIColor (red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
    }
    
    //Mark: fonts
    class func fontArialRegularWIthSize(size:CGFloat) -> UIFont {
        return UIFont(name: "ArialMT", size: size)!
    }
    
    class func fontArialBoldWIthSize(size:CGFloat) -> UIFont {
        return UIFont(name: "Arial-BoldMT", size: size)!
    }
    
}
