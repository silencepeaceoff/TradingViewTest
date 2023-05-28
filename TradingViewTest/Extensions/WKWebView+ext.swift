//
//  WKWebView+ext.swift
//  TradingViewTest
//
//  Created by Dmitrii Tikhomirov on 5/19/23.
//

import WebKit

extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
