//
//  NetworkErrorCase.swift
//  all-for-lesson
//
//  Created by junehee on 8/22/24.
//

import Foundation

/** `HTTP Status Code`
 `400` 필수값 확인 필요 (query, body 등이 비어있는 경우) + 파일의 제한 사항이 맞지 않는 경우/파일의 Content-Type이 맞지 않는 경우
 `401` 계정 확인 필요 (미가입, 비밀번호 불일치) + 인증할 수 없는 토큰 (유효하지 않은 토큰)
 `402` 공백이 포함된 닉네임 사용 불가
 `403` Forbidden. 접근 권한 없음
 `409` 이미 가입된 유저, 이미 사용 중인 닉네임
 `410` 게시물/댓글이 없는 경우 (DB 장애로 게시글 저장 실패, 삭제된 게시물에 접근, 댓글 생성 실패)
 `418` 리프레시 토큰 만료. 재로그인 필요
 `419` 액세스 토큰 만료. 토큰 갱신 필요. (refresh)
 `420` Header에 SesacKey가 없거나 틀린 경우
 `429` 서버 과호출
 `444`비정상 URL
 `445` 게시물/댓글에 대한 권한 없는 경우 (본인 외 게시물에 접근)
 `500` 서버 에러
 */

enum NetworkErrorCase: Int, Error, CaseIterable {
    case BadRequest = 400
    case InvalidAccountOrToken = 401
    case NoBlankNickname = 402
    case Forbidden = 403
    case AlreadyUse = 409
    case ContentNotFound = 410
    case ExpiredRefreshToken = 418
    case ExpiredAccessToken = 419
    case NoSesacKey = 420
    case ServerOverCall = 429
    case InvalidURL = 444
    case InvalidAccessControl = 445
    case ServerError = 500
    case UnknownError
}

extension NetworkErrorCase {
    
    var errorMessage: String {
        switch self {
        case .BadRequest:
            "올바른 요청이 아니예요."
        case .InvalidAccountOrToken:
            "유효하지 않은 사용자(token)에요."
        case .NoBlankNickname:
            "공백이 포함된 닉네임은 사용할 수 없어요."
        case .Forbidden:
            "접근 권한 없음"
        case .AlreadyUse:
            "이미 사용 중이거나 검증 처리가 완료되었어요."
        case .ContentNotFound:
            "콘텐츠를 찾을 수 없어요."
        case .ExpiredRefreshToken:
            "리프레시 토큰이 만료되었어요."
        case .ExpiredAccessToken:
            "액세스 토큰이 만료되었어요."
        case .NoSesacKey:
            "SesacKey를 확인해 주세요."
        case .ServerOverCall:
            "서버 과호출입니다."
        case .InvalidURL:
            "올바르지 않은 URL로 접근하고 있어요."
        case .InvalidAccessControl:
            "본인 외 콘텐츠에 접근하고 있어요."
        case .ServerError:
            "서버 오류가 발생했어요."
        case .UnknownError:
            "알 수 없는 오류가 발생했어요."
        }
    }
    
}
