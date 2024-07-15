//
//
//  Created by Emad Habib on 14/07/2024.
//

import UIKit
import NetworkKit
import PersistenceKit

final class UniversityListInteractor {
    
    var presenter: UniversityListInteractorOutput?
    
    private let universityLoader: UniversityListingLoaderProtocol
    private var isFetching: Bool = false
    private let realmHelper = RealmHelper()
    
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
        // if API returned with data clear old one in db and save a new array
        cleanDBForNewUniversityData()
        saveUniversityDataInLocalDB(universityResponse)
    }
    
    private func handleFailedFetch(_ error: Error) {
        let universityEntities = realmHelper.getAllUniversities().compactMap  { mapToEntity($0) }
        if universityEntities.isEmpty {
            presenter?.didFailToFetchUniversitys(with: error)
        }
        else {
            print("Data Fetched from DB")
            presenter?.didFetchUniversitys(universityEntities)
            stopLoadingIndicators()
        }
    }
    
    private func stopLoadingIndicators() {
        showLoadingIndicator(false)
    }
    
    private func saveUniversityDataInLocalDB(_ universityResponse: [UniversityResponse]){
        let storedData = universityResponse.map({University(from: $0)})
        realmHelper.addUniversities(storedData)
    }
    
    private func cleanDBForNewUniversityData(){
        realmHelper.deleteAllUniversities()
    }
}
