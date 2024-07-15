//
//  UniversityListRouter.swift
//
//
//  Created by Emad Habib on 14/07/2024.
//

import UIKit

final class UniversityListRouter {
    weak var viewController: UniversityListViewController?
    weak var routerDelegate : UniversityListRouterDelegate?
    
    // MARK: - Init
    init(viewController: UniversityListViewController , routerDelegate : UniversityListRouterDelegate?) {
        self.routerDelegate = routerDelegate
        self.viewController = viewController
    }
}

// MARK: Conforming to UniversityListRouterProtocol
extension UniversityListRouter: UniversityListRouterProtocol {
    func navigateToUniversityDetails(for university: UniversityListEntity?) {
        routerDelegate?.navigateToDetails(univeristy: university)
    }
}
