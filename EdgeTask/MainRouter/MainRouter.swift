//
//  MainRouter.swift
//  EdgeTask
//
//  Created by Emad Habib on 15/07/2024.
//

import UIKit
import UniversityListing
import UniversityDetails

final class MainRouter {
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let rootViewController = UniversityListConfigurator.viewController(routerDelegate: self)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        // Create the UIWindow and set the UniversityListViewController as the root view controller
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

extension MainRouter : UniversityListRouterDelegate {
    
    func navigateToDetails(univeristy: UniversityListing.UniversityListEntity?) {
        if let navigationController = window?.rootViewController as? UINavigationController {
            let viewController = UniversityDetailsConfigurator.viewController(university: .init(name: univeristy?.name ?? "",
                                                                                                stateProvince: univeristy?.stateProvince ?? "",
                                                                                                countryCode: univeristy?.countryCode ?? "",
                                                                                                country: univeristy?.country ?? "",
                                                                                                webPages: univeristy?.webPages ?? []),
                                                                              delegate: self)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}

extension MainRouter : DetailsViewControllerDelegate {
    func dismissDetailsAndRefresh() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            if let listingVC = navigationController.viewControllers.first as? UniversityListViewController {
                listingVC.refreshListingData()
            }
        }
    }
}
