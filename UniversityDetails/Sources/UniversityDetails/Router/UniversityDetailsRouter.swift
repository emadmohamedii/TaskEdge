//
//
//  Created by Emad Habib on 15/07/2024.
//

import UIKit

public protocol DetailsViewControllerDelegate: AnyObject {
    func dismissDetailsAndRefresh()
}

final public class UniversityDetailsRouter {
    weak var viewController: UniversityDetailsViewController?
    weak var delegate: DetailsViewControllerDelegate?
    
    // MARK: - Init
    init(viewController: UniversityDetailsViewController , delegate: DetailsViewControllerDelegate?) {
        self.viewController = viewController
        self.delegate = delegate
    }
}

extension UniversityDetailsRouter : UniversityDetailsRouterProtocol {
    func dismissAndReload() {
        self.delegate?.dismissDetailsAndRefresh()
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
