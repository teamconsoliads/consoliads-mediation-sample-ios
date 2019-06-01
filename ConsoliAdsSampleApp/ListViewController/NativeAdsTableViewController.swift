//
//  NativeAdsTableViewController.swift
//  ConsoliAdsNative_Sample
//
//  Created by FazalElahi on 27/11/2018.
//  Copyright © 2018 ConsoliAds. All rights reserved.
//

import Foundation
import GoogleMobileAds
import UIKit

enum nativeAdType {
    case AdmobNativeAd
    case FacebookNativeAd
}

class NativeAdsTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource
{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var fbListIndexTextField: UITextField!
    
    @IBOutlet weak var admobListIndexTextField: UITextField!
    
    // MARK: - Properties
    
    /// The Facebook list index for which user have press the button to load Ad.
    var currentFBListIndex = 0
    
    /// The Admob list index for which user have press the button to load Ad.
    var currentAdmobListIndex = 0
    
    /// The Facebook Native Scene Index from the ConsoliAds Portal Scenes&Ads.
    let fbNativeSceneIndex = 0
    
    /// The Admob Native Scene Index from the ConsoliAds Portal Scenes&Ads.
    let admobNativeSceneIndex = 1
    
    /// The native ads.
    var admobNativeAds = [GADUnifiedNativeAd]()
    
    var fbNativeAds = [FBNativeAd]()
    
    /// The table view items.
    var tableViewItems = [AnyObject]()
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Native Ads TableView"
        ConsoliAdsMediation.sharedInstance()?.setDelegate(self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MenuItem", bundle: nil), forCellReuseIdentifier: "MenuItemViewCell")
        tableView.register(UINib(nibName: "UnifiedNativeAdCell", bundle: nil), forCellReuseIdentifier: "UnifiedNativeAdCell")
        tableView.register(UINib(nibName: "FacebookNativeAdCell", bundle: nil), forCellReuseIdentifier: "FacebookNativeAdCell")
        
    }
    
    func loadFBNativeAd() {
        
    }
    
    func loadAdmobNativeAd() {
       
    }
    
    @IBAction func AddFbNativeAdButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if let text = fbListIndexTextField.text , let index = Int(text) {
            
            if index < tableViewItems.count , index >= 0 {
                currentFBListIndex = index
                addNativeAd(loadNativeAd: .FacebookNativeAd)
            }
            else {
                let message = "Value must be in list range"
                showErrorAlert(message: message)
            }
        }
        else {
            let message = "Value must be integer"
            showErrorAlert(message: message)
        }
    }
    
    @IBAction func AddAdmobNativeAdButtonTapped(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if let text = admobListIndexTextField.text , let index = Int(text) {
            
            if index < tableViewItems.count , index >= 0 {
                currentAdmobListIndex = index
                addNativeAd(loadNativeAd: .AdmobNativeAd)
            }
            else {
                let message = "Value must be in list range"
                showErrorAlert(message: message)
            }
        }
        else {
            let message = "Value must be integer"
            showErrorAlert(message: message)
        }
    }
    
    func showErrorAlert(message messageString: String) {
        
        let alertController = UIAlertController(title: "Alert", message: messageString , preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func addNativeAd (loadNativeAd type: nativeAdType) {
        
        switch type {
        case .AdmobNativeAd:
            ConsoliAdsMediation.sharedInstance()?.addNativeAd(Int32(admobNativeSceneIndex))
            break
        case .FacebookNativeAd:
            ConsoliAdsMediation.sharedInstance()?.addNativeAd(Int32(fbNativeSceneIndex))
            break
        }
    }
    
    func loadNewAdInTableView(atIndex index: Int , item: AnyObject) {
        tableViewItems.insert(item, at: index)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = tableViewItems[indexPath.row] as? FBNativeAd {
            return 339
        }
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let nativeAd = tableViewItems[indexPath.row] as? GADUnifiedNativeAd {
            
            /// Set the native ad's rootViewController to the current view controller.
            nativeAd.rootViewController = self
            
            let nativeAdCell = tableView.dequeueReusableCell(
                withIdentifier: "UnifiedNativeAdCell", for: indexPath)
            
            // Get the ad view from the Cell. The view hierarchy for this cell is defined in
            // UnifiedNativeAdCell.xib.
            let adView : GADUnifiedNativeAdView = nativeAdCell.contentView.subviews
                .first as! GADUnifiedNativeAdView
            
            // Associate the ad view with the ad object.
            // This is required to make the ad clickable.
            adView.nativeAd = nativeAd
            
            // Populate the ad view with the ad assets.
            (adView.headlineView as! UILabel).text = nativeAd.headline
            (adView.priceView as! UILabel).text = nativeAd.price
            if let starRating = nativeAd.starRating {
                (adView.starRatingView as! UILabel).text =
                    starRating.description + "\u{2605}"
            } else {
                (adView.starRatingView as! UILabel).text = nil
            }
            (adView.bodyView as! UILabel).text = nativeAd.body
            (adView.advertiserView as! UILabel).text = nativeAd.advertiser
            // The SDK automatically turns off user interaction for assets that are part of the ad, but
            // it is still good to be explicit.
            (adView.callToActionView as! UIButton).isUserInteractionEnabled = false
            (adView.callToActionView as! UIButton).setTitle(
                nativeAd.callToAction, for: UIControl.State.normal)
            
            return nativeAdCell
        }
        else if let fbNativeAd = tableViewItems[indexPath.row] as? FBNativeAd {
            
            let nativeAdCell = tableView.dequeueReusableCell(
                withIdentifier: "FacebookNativeAdCell", for: indexPath) as! FacebookNativeAdCell
            
            nativeAdCell.adTitleLabel.text = fbNativeAd.advertiserName;
            nativeAdCell.adBodyLabel.text = fbNativeAd.bodyText;
            nativeAdCell.adSocialContextLabel.text = fbNativeAd.socialContext;
            nativeAdCell.sponsoredLabel.text = fbNativeAd.sponsoredTranslation;
            setCallToActionButton(callToActionString: fbNativeAd.callToAction ?? "", callToActionButton: nativeAdCell.adToCallButton)
            
            
            let gapToBorder: CGFloat = 9.0
            let gapToCTAButton: CGFloat = 8.0
            var adBodyLabelFrame: CGRect = nativeAdCell.adBodyLabel.frame
            
            if fbNativeAd.callToAction?.isEmpty == false {
                adBodyLabelFrame.size.width = nativeAdCell.adMediaView.bounds.size.width - (gapToBorder * 2)
            }
            else {
                adBodyLabelFrame.size.width = nativeAdCell.adMediaView.bounds.size.width - gapToCTAButton - gapToBorder - (nativeAdCell.adMediaView.bounds.size.width - nativeAdCell.adToCallButton.frame.origin.x)
            }
            nativeAdCell.adBodyLabel.frame = adBodyLabelFrame
            
            nativeAdCell.adTitleLabel.nativeAdViewTag = .title
            nativeAdCell.adBodyLabel.nativeAdViewTag = .body
            nativeAdCell.adSocialContextLabel.nativeAdViewTag = .socialContext
            nativeAdCell.adToCallButton.nativeAdViewTag = .callToAction
            
            // Specify the clickable areas. Views you were using to set ad view tags should be clickable.
            let clickableViews: [UIView] = [nativeAdCell.adIconView, nativeAdCell.adTitleLabel, nativeAdCell.adBodyLabel, nativeAdCell.adSocialContextLabel, nativeAdCell.adToCallButton]
            fbNativeAd.registerView(forInteraction: nativeAdCell, mediaView: nativeAdCell.adMediaView, iconView: nativeAdCell.adIconView, viewController: self, clickableViews: clickableViews)
            
            nativeAdCell.adChoicesView.nativeAd = fbNativeAd
            nativeAdCell.adChoicesView.corner = .topRight
            nativeAdCell.adChoicesView.isHidden = false
            
            return nativeAdCell
        }
        else {
            
            let menuItem = tableViewItems[indexPath.row] as? MenuItem
            
            let reusableMenuItemCell = tableView.dequeueReusableCell(withIdentifier: "MenuItemViewCell",
                                                                     for: indexPath) as! MenuItemViewCell
            
            reusableMenuItemCell.nameLabel.text = menuItem?.name
            reusableMenuItemCell.descriptionLabel.text = menuItem?.description
            reusableMenuItemCell.priceLabel.text = menuItem?.price
            reusableMenuItemCell.categoryLabel.text = menuItem?.category
            reusableMenuItemCell.photoView.image = menuItem?.photo
            
            return reusableMenuItemCell
        }
    }
    
    func setCallToActionButton(callToActionString: String , callToActionButton: UIButton) {
        
        if !callToActionString.isEmpty {
            callToActionButton.isHidden = false
            callToActionButton.setTitle(callToActionString, for: UIControl.State.normal)
        } else {
            callToActionButton.isHidden = true
        }
    }
}

extension NativeAdsTableViewController: ConsoliAdsMediationDelegate {
    // MARK: - UITableView delegate methods
    
    func onConsoliAdsInitializationSuccess(_ status: Bool) {
        
    }
    
    func onInterstitialAdShown() {
        
    }
    
    func onInterstitialAdClicked() {
        
    }
    
    func onVideoAdShown() {
        
    }
    
    func onVideoAdClicked() {
        
    }
    
    func onRewardedVideoAdShown() {
        
    }
    
    func onRewardedVideoAdCompleted() {
        
    }
    
    func onRewardedVideoAdClick() {
        
    }
    
    func onNativeAdLoaded(_ adNetworkName: Int32, for index: Int32) {
        
        if let admobNativeAd = ConsoliAdsMediation.sharedInstance()?.getNativeAdSceneIndex(Int32(admobNativeSceneIndex), at: (index)) as? GADUnifiedNativeAd {
            
            print("Received native ad: \(admobNativeAd)")
            admobNativeAds.append(admobNativeAd)
            loadNewAdInTableView(atIndex: currentAdmobListIndex , item: admobNativeAd)
        }
        else if let fbNativeAd = ConsoliAdsMediation.sharedInstance()?.getNativeAdSceneIndex(Int32(fbNativeSceneIndex), at: (index)) as? FBNativeAd {
            
            print("Received native ad: \(fbNativeAd)")
            fbNativeAds.append(fbNativeAd)
            loadNewAdInTableView(atIndex: currentFBListIndex , item: fbNativeAd)
        }
        else {
            print("Received native ad: but ad value is null " )
        }
    }
    
    func onNativeAdFailed(toLoad adNetworkName: Int32, for index: Int32) {
    }
}
