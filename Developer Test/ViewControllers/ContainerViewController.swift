//
//  ContainerViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit
import Localize_Swift

class ContainerViewController: UIViewController {

    @IBOutlet weak var languageCollectionView: UICollectionView!
    @IBOutlet weak var schoolAppBannerView: SchoolAppBannerView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var languageViewHeightConstraint: NSLayoutConstraint!
    
    var languages: [Language] = [
        Language(flag: "United Kingdom", name: "EN"),
        Language(flag: "France", name: "FR")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
//        languageViewHeightConstraint.constant = 50
    }
    
    private func initCollectionView() {
        languageCollectionView.delegate = self
        languageCollectionView.dataSource = self
        languageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        languageCollectionView.register(UINib(nibName: "LanguageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LanguageCollectionViewCell")
        languageCollectionView.register(UINib(nibName: "LanguageSelectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LanguageSelectCollectionViewCell")
        
        languageCollectionView.layer.cornerRadius = 16
        languageCollectionView.layer.masksToBounds = true
    }
    
    func changeLanguage(index: Int) {
        let selectedLanguage = languages[index].name.lowercased()
        print("selected language is now \(selectedLanguage)")
        AppManager.shared.setPreferredLanguage(language: selectedLanguage)
        Localize.setCurrentLanguage(selectedLanguage)
        languageCollectionView.reloadItems(at: [IndexPath(row: 0, section: 0)])
        schoolAppBannerView.changeLanguage()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "changeLanguage"), object: nil)
    }
}

// MARK: - UICollectionViewDelegates
extension ContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + languages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = languageCollectionView.dequeueReusableCell(withReuseIdentifier: "LanguageSelectCollectionViewCell", for: indexPath) as! LanguageSelectCollectionViewCell
            cell.setupCell(language: AppManager.shared.getPreferredLanguage())
            return cell
        } else {
            let cell = languageCollectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCollectionViewCell", for: indexPath) as! LanguageCollectionViewCell
            cell.setupCell(language: languages[indexPath.row-1])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 70, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: { [self] in
            if languageViewHeightConstraint.constant == 40 {
                languageViewHeightConstraint.constant = CGFloat(40 + (languages.count * 54))
                self.view.layoutIfNeeded()
            } else {
                languageViewHeightConstraint.constant = 40
                self.view.layoutIfNeeded()
            }
        }, completion: { [self] finished in
            if indexPath.row > 0 {
                changeLanguage(index: indexPath.row - 1)
            }
        })
    }
}
