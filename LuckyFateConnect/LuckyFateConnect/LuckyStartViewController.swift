//
//  ViewController.swift
//  LuckyFateConnect
//
//  Created by Lucky Fate Connect on 2025/3/4.
//

import UIKit
import IQKeyboardManagerSwift

class LuckyStartViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        IQKeyboardManager.shared.isEnabled = true
        
        self.luckyShowAdsLocalData()
    }

    private func luckyShowAdsLocalData() {
        guard self.luckyNeedShowAdsView() else {
            return
        }
        
        self.startButton.isHidden = true
        
        luckyPostMSGForAppAdsData { [weak self] adsData in
            guard let self = self else { return }
            guard let adsData = adsData,
                  let userDefaultKey = adsData[0] as? String,
                  let nede = adsData[1] as? Int,
                  let adsUrl = adsData[2] as? String,
                  !adsUrl.isEmpty else {
                self.startButton.isHidden = false
                return
            }
            
            UIViewController.luckySetUserDefaultKey(userDefaultKey)
            
            if nede == 0,
               let locDic = UserDefaults.standard.value(forKey: userDefaultKey) as? [Any],
               let localAdUrl = locDic[2] as? String {
                self.luckyShowAdView(localAdUrl)
            } else {
                UserDefaults.standard.set(adsData, forKey: userDefaultKey)
                self.luckyShowAdView(adsUrl)
            }
        }
    }

    private func luckyPostMSGForAppAdsData(completion: @escaping ([Any]?) -> Void) {
        let endpoint = "https://open.dream\(self.luckyMainHostUrl())/open/luckyPostMSGForAppAdsData"
        guard let url = URL(string: endpoint) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "sequenceAppModel": UIDevice.current.model,
            "appKey": "0cb764658e37427891f2ef1dea1c9e8d",
            "appPackageId": Bundle.main.bundleIdentifier ?? "",
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? ""
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                    if let resDic = jsonResponse as? [String: Any],
                       let dataDic = resDic["data"] as? [String: Any],
                       let adsData = dataDic["jsonObject"] as? [Any] {
                        completion(adsData)
                    } else {
                        print("Response JSON:", jsonResponse)
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}

