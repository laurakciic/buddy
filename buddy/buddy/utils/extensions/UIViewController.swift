//
//  UIViewController.swift
//  buddy
//
//  Created by Laura Kovačić on 14.06.2023..
//

import UIKit

extension UIViewController {
    
    /** get keyWindow of current application so you can change the rootViewController */
    var keyWindow: UIWindow? {
        var window = view.window
        
        if window == nil {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                return windowScene.windows.first
            }
        }
        
        return window
    }
    
    /** checks if VC has keyWindow (it will always have it) and sets it as rootViewController */
    func showAsRoot() {
        if let window = keyWindow {
            window.rootViewController = self
            window.makeKeyAndVisible()
        }
    }
}
