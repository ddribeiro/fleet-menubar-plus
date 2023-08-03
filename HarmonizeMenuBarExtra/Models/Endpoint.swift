//
//  Endpoint.swift
//  HarmonizeMenuBarExtra
//
//  Created by Dale Ribeiro on 8/3/23.
//

import Foundation

struct Endpoint<T: Decodable> {
    var path: String
    var type: T.Type
    var method = HTTPMethod.get
    var headers = [String: String]()
    var keyPath: String?
}

extension Endpoint where T == [Host] {
    static let hosts = Endpoint(
        path: "hosts",
        type: [Host].self,
        keyPath: "hosts"
    )
}
