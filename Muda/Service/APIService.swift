//
//  APIService.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation
import Moya

enum APIService {
    case fetchMusic(media: String = "music", term: String)
}

extension APIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .fetchMusic(_,_):
            return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchMusic(_,_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetchMusic(let media, let term):
            let params: [String: Any] = [
                "media": media,
                "term": term
            ]
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
