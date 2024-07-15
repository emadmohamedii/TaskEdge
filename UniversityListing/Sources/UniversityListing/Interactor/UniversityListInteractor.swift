//
//
//  Created by Emad Habib on 14/07/2024.
//

import UIKit
import NetworkKit

final class UniversityListInteractor {
    
    var presenter: UniversityListInteractorOutput?
    
    private let universityLoader: UniversityListingLoaderProtocol
    private var isFetching: Bool = false
    
    // MARK: Init
    init(loader: UniversityListingLoaderProtocol) {
        self.universityLoader = loader
    }
}

extension UniversityListInteractor: UniversityListPresenterInteractorProtocol {
    
    // MARK: - Get University List
    func fetchUniversityList() {
        guard shouldFetchUniversityList else { return }
        
        isFetching = true
        showLoadingIndicator(true)
        universityLoader.loadUniveristy(with: .init(country: "United Arab Emirates")) { [weak self] result in
            guard let self = self else { return }
            defer {
                self.isFetching = false
                DispatchQueue.main.async {
                    self.stopLoadingIndicators()
                }
            }
            DispatchQueue.main.async {
                self.handleFetchedResult(result)
            }
        }
    }
    
    private func mapToEntity(_ model: UniversityResponse) -> UniversityListEntity {
        .init(name: model.name ?? "",
              stateProvince: model.stateProvince ?? "",
              countryCode: model.alphaTwoCode ?? "",
              country: model.country ?? "",
              webPages: model.webPages ?? [])
    }
}


// MARK: - Handle Fetch University Result
extension UniversityListInteractor {
    private var shouldFetchUniversityList: Bool {
        !isFetching
    }
    
    private func showLoadingIndicator(_ isVisible: Bool) {
        presenter?.setLoadingIndicatorVisible(isVisible)
    }
    
    private func handleFetchedResult(_ result: Result<[UniversityResponse], Error>) {
        switch result {
        case .success(let universityResponse):
            handleSuccessfulFetch(universityResponse)
        case .failure(let error):
            handleFailedFetch(error)
        }
    }
    
    private func handleSuccessfulFetch(_ universityResponse: [UniversityResponse]) {
        let universityEntities = universityResponse.compactMap { mapToEntity($0) }
        presenter?.didFetchUniversitys(universityEntities)
    }
    
    private func handleFailedFetch(_ error: Error) {
        presenter?.didFailToFetchUniversitys(with: error)
    }
    
    private func stopLoadingIndicators() {
        self.showLoadingIndicator(false)
    }
}
