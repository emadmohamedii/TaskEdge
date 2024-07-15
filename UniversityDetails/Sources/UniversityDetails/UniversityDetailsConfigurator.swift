//
//  UniversityDetailsConfigurator.swift
//
//
//  Created by Emad Habib on 14/07/2024.
//

import Foundation
import NetworkKit

public final class UniversityDetailsConfigurator {
    
    // MARK: Configuration
    public class func viewController(university : UniversityDetailsEntity? , delegate:  DetailsViewControllerDelegate?) -> UniversityDetailsViewController {
        let view = UniversityDetailsViewController(nibName: "UniversityDetailsViewController", bundle: .module)
        let router = UniversityDetailsRouter(viewController: view,delegate: delegate)
        let presenter = UniversityDetailsPresenter(view: view, university: university , router: router)
        view.presenter = presenter
        return view
    }
}

// Controller --> Presenter
protocol UniversityDetailsPresentable: AnyObject {
    func reloadListing()
    func viewDidLoad()
}

// Presenter --> Controller
protocol UniversityDetailsControllerProtocol: AnyObject {
    func showUniversityDetails(univeristy : UniversityDetailsEntity?)
}

// Presenter --> Router
protocol UniversityDetailsRouterProtocol: AnyObject {
    func dismissAndReload()
}
