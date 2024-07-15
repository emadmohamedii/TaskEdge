//
//  UniversityListConfigurator.swift
//
//
//  Created by Emad Habib on 14/07/2024.
//

import UIKit
import NetworkKit

public protocol UniversityDetailsBuilderInput {
    var id: String { get }
}

struct UniversityDetailsInput: UniversityDetailsBuilderInput {
    let id: String
}

public protocol UniversityListRouterDelegate: AnyObject {
    func navigateToDetails(univeristy : UniversityListEntity?)
}

final public class UniversityListConfigurator {
    
    // MARK: Configuration
    public class func viewController(routerDelegate : UniversityListRouterDelegate?) -> UniversityListViewController {
        let view = UniversityListViewController(nibName: "UniversityListViewController", bundle: .module)
        let loader = UniversityListingLoader()
        let interactor = UniversityListInteractor(loader: loader)
        let router = UniversityListRouter(viewController: view, routerDelegate: routerDelegate)
        let presenter = UniversityListPresenter(view: view,
                                                interactor: interactor,
                                                router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}

// MARK: - Protocols
// Controller --> Presenter
protocol UniversityListPresentable: AnyObject {
    var  universitysItemsCount: Int { get }
    func getItem(at index: Int) -> UniversityListEntity?
    func navigateToUniversityDetails(with index: Int)
}

protocol UniversityListPresenterProtocol: UniversityListPresentable {
    func viewDidLoad()
}

// Presenter --> Controller
protocol UniversityListControllerProtocol: AnyObject {
    func reloadCollectionView()
    func presentError(with message: String)
    func animateLoadingIndicator()
    func stopLoadingIndicator()
    func showCollectionPlaceholderLabel()
    func hideCollectionPlaceholderLabel()
    func updateCollectionPlaceholderLabel(text: String)
}

// Presenter --> Interactor
protocol UniversityListPresenterInteractorProtocol: AnyObject {
    func fetchUniversityList()
}

// Interactor --> Presenter
protocol UniversityListInteractorOutput: AnyObject {
    func didFetchUniversitys(_ universities: [UniversityListEntity])
    func didFailToFetchUniversitys(with error: Error)
    func setLoadingIndicatorVisible(_ isVisible: Bool)
}

// Presenter --> Router
protocol UniversityListRouterProtocol: AnyObject {
    func navigateToUniversityDetails(for university: UniversityListEntity?)
}
