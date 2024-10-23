//
//  APIService.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import Foundation
import Alamofire
import Combine

//enum APIService {
//    case fetchMusic(media: String = "music", term: String)
//}
//
//extension APIService: TargetType {
//    var baseURL: URL {
//        return URL(string: "https://itunes.apple.com")!
//    }
//    
//    var path: String {
//        switch self {
//        case .fetchMusic(_,_):
//            return "/search"
//        }
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .fetchMusic(_,_):
//            return .get
//        }
//    }
//    
//    var task: Task {
//        switch self {
//        case .fetchMusic(let media, let term):
//            let params: [String: Any] = [
//                "media": media,
//                "term": term
//            ]
//                        
//            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
//        }
//    }
//    
//    var headers: [String : String]? {
//        return ["Content-type": "application/json"]
//    }
//}


final class APIService {
    var cancellable = Set<AnyCancellable>()
    
    func fetchMusics(of keyword: String) -> AnyPublisher<[Music], Error> {
      // 1. url 주소 생성. 실패시 Fail로 publisher 반환
        guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=\(keyword)") else {
        return Fail(error: URLError(.badURL))
               .eraseToAnyPublisher()
      }
        
        // 2. completion Handler를 @escaping closure 대신 Future로 사용
      return Future() { promise in
        AF.request(url)
          .publishDecodable(type: MusicList.self)      // 값을 디코딩함
          .value()                                  // 디코딩된 값을 AnyPublisher<Data, AFError> 형태로
          .sink { completion in
            switch completion {
            case .finished:
              print("fetchMusics finished")
            case .failure(let error):
              print("fetchMusics error: \(error)")
              promise(.failure(URLError(.badServerResponse)))    // 실패할 경우 에러값 publisher 반환
            }
          } receiveValue: { result in
              promise(.success(result.results))// 성공한 경우 데이터값을 담은 publisher 반환
              print("result: ",result.results)
          }
          .store(in: &self.cancellable)              // 작업 후 메모리 해제
      }
      .eraseToAnyPublisher()
    }
}
