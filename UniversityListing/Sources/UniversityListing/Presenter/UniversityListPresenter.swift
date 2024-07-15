//
//
//  Created by Emad Habib on 14/07/2024.
//

import UIKit

final class UniversityListPresenter: NSObject {
    // MARK: - Properites
    private weak var view: UniversityListControllerProtocol?
    private var interactor: UniversityListPresenterInteractorProtocol?
    private var router: UniversityListRouterProtocol?
    private var universities = [UniversityListEntity]()
    private let loadingDataText = "Loading data..."
    private let errorPlaceHolderText = "No Data to Present"
    
    // MARK: - Init
    init(view: UniversityListControllerProtocol?,
         interactor: UniversityListPresenterInteractorProtocol?,
         router: UniversityListRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Conform to UniversityListPresenterProtocol
extension UniversityListPresenter: UniversityListPresenterProtocol {
    
    func getItem(at index: Int) -> UniversityListEntity? {
        self.universities[safe: index]
    }
    
    var universitysItemsCount: Int {
        self.universities.count
    }
    
    func viewDidLoad() {
        self.universities = []
        self.view?.reloadCollectionView()
        
        // Show PlaceHolder label during loading data
        handleShowingEmptyListPlaceHolder(with: loadingDataText)
        // Load Data
        interactor?.fetchUniversityList()
    }
    
    func navigateToUniversityDetails(with index: Int) {
        guard let selectedUniversity = self.universities[safe: index] else { return }
        self.router?.navigateToUniversityDetails(for: selectedUniversity)
    }
    
    func setLoadingIndicatorVisible(_ isVisible: Bool) {
        guard isVisible else {
            self.view?.stopLoadingIndicator()
            return
        }
        handleShowingEmptyListPlaceHolder(with: loadingDataText)
        self.view?.animateLoadingIndicator()
    }
    
    private func handleShowingEmptyListPlaceHolder(with text: String) {
        guard self.universities.isEmpty else { return }
        self.view?.updateCollectionPlaceholderLabel(text: text)
        self.view?.showCollectionPlaceholderLabel()
    }
}

// MARK: Conform to UniversityListInteractorOutput
extension UniversityListPresenter: UniversityListInteractorOutput {
    
    func didFetchUniversitys(_ universities: [UniversityListEntity]) {
        defer {
            self.view?.hideCollectionPlaceholderLabel()
            self.view?.reloadCollectionView()
        }
        self.universities = universities
    }
    
    func didFailToFetchUniversitys(with error: any Error) {
        self.view?.presentError(with: error.localizedDescription)
        self.handleShowingEmptyListPlaceHolder(with: errorPlaceHolderText)
    }
}
