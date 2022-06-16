//
//  VKAuthorizationViewController.swift
//  IOSLessons
//
//  Created by Aleksandr Derevenskih on 15.06.2022.
//

import UIKit
import WebKit

class VKAuthorizationViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self

        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()

    }

    private func configureWebView() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = VKApi.authorize.host
        urlComponents.path = VKApi.authorize.endPoint
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: Session.clientId),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value:"https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68") ]
        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}

extension VKAuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationResponse: WKNavigationResponse,
                 decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }

        if let token = params["access_token"] {
            Session.instance.token = token
            decisionHandler(.cancel)
            performSegue(withIdentifier: "loadDataSegue", sender: nil)
        } else {
            configureWebView()
        }
    }
}
