//
//  SceneDelegate.swift
//  StarRatingControl_Example
//
//  Created by Rafael Moura on 29/07/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder,
                     UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        
        windowScene.delegate = self
        
        let window = UIWindow(windowScene: windowScene)
        
        let navController = UINavigationController(rootViewController: ViewController())
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
