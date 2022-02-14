//
//  QueueAPI.swift
//  usKet_HobbyFriend
//
//  Created by 이경후 on 2022/02/07.
//

import Moya

final class QueueAPI {
    
    static private let provider = MoyaProvider<QueueTarget>()
    
    static func findFriend(idToken: String, parm: FindFriendParm, onCompletion : @escaping (Int?) -> Void) {
        provider.request(.findFriend(idToken: idToken, parm)) { result in
                switch result {
                case .success(let response):
                    onCompletion(response.statusCode)
                case .failure(let error):
                    onCompletion(error.response?.statusCode)
                }
            }
    }
    
    static func stopFinding(idToken: String, onCompletion : @escaping (Int?) -> Void) {
        
        provider.request(.stopFinding(idToken: idToken)) { result in
                switch result {
                case .success(let response):
                    onCompletion(response.statusCode)
                case .failure(let error):
                    onCompletion(error.response?.statusCode)
                }
            }
    }
    
    static func questSurround(idToken: String, parm: QuestSurroundParm, onCompletion : @escaping (Friends?, Int?) -> Void) {
        provider.request(.questSurround(idToken: idToken, parm)) { result in
                switch result {
                case .success(let response):
                    onCompletion(try? response.map(Friends.self), response.statusCode)
                case .failure(let error):
                    onCompletion(nil, error.response?.statusCode)
                }
            }
        
    }
    
    static func requestFriend(idToken: String, parm: RequestFriendParm, onCompletion: @escaping (Int?) -> Void) {
        provider.request(.stopFinding(idToken: idToken)) { result in
                switch result {
                case .success(let response):
                    onCompletion(response.statusCode)
                case .failure(let error):
                    onCompletion(error.response?.statusCode)
                }
            }
        
    }
    
    static func acceptFriend(idToken: String, parm: AcceptFriendParm, onCompletion: @escaping (Int?) -> Void) {
        provider.request(.stopFinding(idToken: idToken)) { result in
                switch result {
                case .success(let response):
                    onCompletion(response.statusCode)
                case .failure(let error):
                    onCompletion(error.response?.statusCode)
                }
            }
        
    }
    
    static func userCheckMatch(idToken: String, onCompletion: @escaping (Match?, Int?) -> Void) {
        provider.request(.stopFinding(idToken: idToken)) { result in
                switch result {
                case .success(let response):
                    onCompletion(try? response.map(Match.self), response.statusCode)
                case .failure(let error):
                    onCompletion(nil, error.response?.statusCode)
                }
            }
    }
}