//
//  FindFriendsViewModel.swift
//  usKet_HobbyFriend
//
//  Created by 이경후 on 2022/02/14.
//

import Foundation

final class FindFriendsViewModel {
    
    var errorMessage: String = ""
    
    func stopFindingFriend(onComletion: @escaping (String?) -> Void) {
        let idToken = Helper.shared.putIdToken()
        
        QueueAPI.stopFinding(idToken: idToken) { statusCode in
            switch statusCode {
            case 200:
                onComletion(nil)
            case 201:
                onComletion("누군가와 취미를 함께하기로 약속하셨어요!")
            case 401:
                Helper.shared.getIdToken(refresh: true) { _ in
                    onComletion("정보 갱신중입니다.다시 시도해주세요!")
                }
            default:
                onComletion("오류가 발생했습니다. 다시 시도해주세요.")
            }
        }
    }
    
    func questSurround(onCompletion: @escaping (Friends?, Int?, String?) -> Void) {
        
        let idToken = Helper.shared.putIdToken()
        let location = Helper.shared.myLocation
        
        let parm = QuestSurroundParm(region: location.region, lat: location.lat, long: location.long)
        
        QueueAPI.questSurround(idToken: idToken, parm: parm) { friends, statusCode in
            
            switch statusCode {
            case 200:
                onCompletion(friends, statusCode, nil)
            case 401:
                Helper.shared.getIdToken(refresh: true) { idToken in
                    guard idToken != nil else {
                        self.errorMessage = "토큰 갱신에 실패했어요. 다시 시도해주세요."
                        onCompletion(nil, statusCode, self.errorMessage)
                        return
                    }
                    self.errorMessage = "토큰 갱신에 성공했습니다. 다시 시도해주세요."
                    onCompletion(nil, statusCode, self.errorMessage)
                }
            default:
                self.errorMessage = "알 수없는 오류가 발생했습니다."
                onCompletion(nil, statusCode, self.errorMessage)
            }
        }
    }
}