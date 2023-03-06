//
//  AdocentApp.swift
//  Adocent
//
//  Created by 김찬형 on 2022/09/14.
//

import SwiftUI
import FirebaseCore
import SDWebImage
import SDWebImageSVGCoder

@main
struct AdocentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var firestoreUserRepository = FirestoreUserRepository()
    @StateObject private var modelData = ModelData()
    
    init() {
        setUpDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(galleryList: [Gallery](), exhibitionList: [Exhibition](), workList: [Work](), docentTourList: [DocentTour]())
                .environmentObject(firestoreUserRepository)
                .environmentObject(modelData)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

private extension AdocentApp {
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}
