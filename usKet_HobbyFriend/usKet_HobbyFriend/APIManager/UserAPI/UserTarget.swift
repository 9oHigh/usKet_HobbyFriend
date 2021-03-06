//
//  UserAPI.swift
//  usKet_HobbyFriend
//
//  Created by 이경후 on 2022/02/05.
//

import Moya

enum UserTarget {
    
    case getUser(idToken: String)
    case signupUser(idToken: String, SignupParm)
    case withdrawUser(idToken: String)
    case updateMypage(idToken: String, MypageParm)
    case updateFCMToken(idToken: String, FCMtokenParm)
    case reportUser(idToken: String, Evaluation)
}

// TargetType 프로토콜을 채택할 경우 다음과같이 프로퍼티들이 생성된다.
extension UserTarget: TargetType {

    var baseURL: URL {
        return URL(string: "http://test.monocoding.com:35484")!
    }

    var path: String {
        // 경로의 경우 기존의 타겟을 Switch문으로 해결하자
        switch self {

        case .getUser : return "user"
        case .signupUser : return "user"
        case .withdrawUser : return "user/withdraw"
        case .updateMypage : return "user/update/mypage"
        case .updateFCMToken : return "user/update_fcm_token"
        case .reportUser : return "user/report"
        }
    }

    var method: Moya.Method {
        // HTTP Method
        switch self {
        case .getUser: return .get
        case .signupUser: return .post
        case .withdrawUser: return .post
        case .updateMypage: return .post
        case .updateFCMToken: return .put
        case .reportUser : return .post
        }
    }

    var task: Task {
        switch self {

        case .getUser:
            return .requestPlain

        case .signupUser(_, let parameter):
            return .requestParameters(parameters: [
                "phoneNumber": parameter.phoneNumber,
                "FCMtoken": parameter.FCMtoken,
                "nick": parameter.nick,
                "birth": parameter.birth,
                "email": parameter.email,
                "gender": parameter.gender
            ], encoding: URLEncoding.default)

        case .withdrawUser:
            return .requestPlain

        case .updateMypage(_, let parameter):
            return .requestParameters(parameters: [
                "searchable": parameter.searchable,
                "ageMin": parameter.ageMin,
                "ageMax": parameter.ageMax,
                "gender": parameter.gender,
                "hobby": parameter.hobby
            ], encoding: URLEncoding.default)

        case .updateFCMToken(_, let parameter):
            return .requestParameters(parameters: [
                "FCMtoken": parameter.FCMtoken
            ], encoding: URLEncoding.default)
        case .reportUser(_, let parameter):
            return .requestParameters(parameters: [
                "otheruid": parameter.otheruid,
                "reportedReputation": parameter.reputation,
                "comment": parameter.comment
            ], encoding: URLEncoding.default)
            
        }
    }

    var headers: [String: String]? {

        switch self {
        case .getUser(let idToken):
            return [
                "idtoken": idToken
            ]
        case .signupUser(let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        case .withdrawUser(let idToken):
            return [
                "idtoken": idToken
            ]
        case .updateFCMToken(let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        case .updateMypage(let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        case .reportUser(idToken: let idToken, _):
            return [
                "idtoken": idToken,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }

    }
}
