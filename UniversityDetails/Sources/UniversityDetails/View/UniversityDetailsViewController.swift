//
//  UniversityDetailsViewController.swift
//
//
//  Created by Emad Habib on 15/07/2024.
//

import UIKit

public final class UniversityDetailsViewController: UIViewController {
    
    @IBOutlet weak var universityNameLbl:UILabel!
    @IBOutlet weak var universityStateLbl:UILabel!
    @IBOutlet weak var universityCountryLbl:UILabel!
    @IBOutlet weak var universityCountryCodeLbl:UILabel!
    @IBOutlet weak var universityWebPageLbl:UILabel!
    
    // MARK: Properties
    var presenter: UniversityDetailsPresentable?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func didTapRefresh(){
        
        presenter?.reloadListing()
    }
}

extension UniversityDetailsViewController : UniversityDetailsControllerProtocol {
    func showUniversityDetails(univeristy: UniversityDetailsEntity?) {
        if let university = univeristy {
            universityNameLbl.text = university.name
            universityStateLbl.text = university.stateProvince
            universityCountryLbl.text = univeristy?.country
            universityCountryCodeLbl.text = univeristy?.countryCode
            universityWebPageLbl.text = univeristy?.webPage.map({$0}).joined(separator: ",")
        }
        else {
            print("Show Error")
        }
    }
}
