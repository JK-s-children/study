//
//  SceneDelegate.swift
//  CollectionViewLayout
//
//  Created by jung on 3/10/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let window = UIWindow(windowScene: windowScene)
    let vc = ViewController()
    window.rootViewController = vc
    window.makeKeyAndVisible()
    
    self.window = window
  }
}

