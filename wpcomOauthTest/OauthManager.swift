//
//  OauthManager.swift
//  schemetest
//
//  Created by Jorge Bernal Ordovas on 27/05/16.
//  Copyright © 2016 WordPress. All rights reserved.
//

import Foundation
import UIKit

struct OauthManager {
    private enum Credentials {
        CHANGE_THESE_AND_REMOVE_THIS_LINE
        static let clientId = 0
        static let clientSecret = "*******"
        static let redirectUri = "*******"
    }

    private let baseURL = NSURL(string: "https://public-api.wordpress.com/oauth2/")!

    private var redirectUri: String {
        return Credentials.redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())!
    }

    private var authorizeURL: NSURL {
        return NSURL(string: "authorize?client_id=\(Credentials.clientId)&redirect_uri=\(redirectUri)&response_type=code", relativeToURL: baseURL)!
    }

    private var redirectHost: String? {
        let redirectURL = NSURL(string: Credentials.redirectUri)
        return redirectURL?.host
    }

    func authorize() {
        UIApplication.sharedApplication().openURL(authorizeURL)
    }

    func handleOpenURL(url: NSURL) -> Bool {
        guard let host = redirectHost where url.host == host else {
            return false
        }

        print("Launched with url: \(url)")

        guard let components = NSURLComponents(URL: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            let code = queryItems.filter({ $0.name == "code" }).first?.value else {
                print("Code not found in callback")
                return false
        }

        let alert = UIAlertController(title: "OAuth2", message: "Called back with code \(code)", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)

        return true
    }
}
