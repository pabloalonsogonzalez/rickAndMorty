//
//  NetworkLogger.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation

class NetworkLogger {
    
    static func log(url: URL) {
        print("\n - - - - - - - - - - REQUEST - - - - - - - - - - \n")
        print(url.absoluteString)
        print("\n - - - - - - - - - - END - - - - - - - - - - \n")
    }

    static func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
        print("\n - - - - - - - - - - RESPONSE - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        var output = ""
        if let urlString = urlString {
          output += "\(urlString)"
          output += "\n\n"
        }
        if let statusCode =  response?.statusCode {
          output += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
          output += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
          output += "\(key): \(value)\n"
        }
        if let body = data {
          output += "\n\(String(data: body, encoding: .utf8) ?? "")\n"
        }
        if error != nil {
          output += "\nError: \(error!.localizedDescription)\n"
        }
        print(output)
    }

}
