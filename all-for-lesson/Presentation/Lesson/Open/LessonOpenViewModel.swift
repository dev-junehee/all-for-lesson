//
//  LessonOpenViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonOpenViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let titleText: ControlProperty<String?>     /// 레슨 제목
        let priceText: ControlProperty<String?>     /// 레슨 가격
        let majorFieldTap: ControlEvent<Void>       /// 레슨 과목 필드 탭
        let majorSelect: ControlEvent<[String]>     /// 레슨 과목 선택
        let locationFieldTap: ControlEvent<Void>    /// 레슨 위치 필드 탭
        let locationSelect: ControlEvent<[String]>  /// 레슨 위치 선택
        let typeFieldTap: ControlEvent<Void>        /// 레슨 타입 필드 탭
        let typeSelect: ControlEvent<[String]>      /// 레슨 타입 선택
        let contentText: ControlProperty<String?>   /// 레슨 소개
        
        let photoButtonTap: ControlEvent<Void>       /// 사진 버튼 탭
        let firstPhotoName: BehaviorSubject<String?>  /// 첫 번째 사진 파일명
        let firstPhoroFile: BehaviorSubject<Data?>    /// 첫 번째 사진 png 이미지
        let secondPhotoName: BehaviorSubject<String?> /// 두 번째 사진 파일명
        let secondPhotoFile: BehaviorSubject<Data?>   /// 두 번째 사진 png 이미지
        let thirdPhotoName: BehaviorSubject<String?>  /// 세 번째 사진 파일명
        let thirdPhoroFile: BehaviorSubject<Data?>    /// 세 번째 사진 png 이미지
        
        let postButtonTap: ControlEvent<Void>        /// 레슨 개설 버튼 탭
    }
    
    struct Output {
        let majorList: PublishSubject<[String]>
        let selectedMajor: PublishSubject<String?>
        let locationList: PublishSubject<[String]>
        let selectedLocation: PublishSubject<String?>
        let typeList: PublishSubject<[String]>
        let selectedType: PublishSubject<String?>
        let photoButtonTap: ControlEvent<Void>
        let postDone: PublishSubject<Void>
    }
    
    func transform(input: Input) -> Output {
        let majorList = PublishSubject<[String]>()
        let selectedMajor = PublishSubject<String?>()
        let locationList = PublishSubject<[String]>()
        let selectedLocation = PublishSubject<String?>()
        let typeList = PublishSubject<[String]>()
        let selectedType = PublishSubject<String?>()
        // 
        // let firstPhotoName = BehaviorSubject<String?>(value: )
        // let firstPhoroFile = BehaviorSubject<Data?>(value: nil)
        // let secondPhotoName = BehaviorSubject<String?>(value: "")
        // let secondPhotoFile = BehaviorSubject<Data?>(value: nil)
        // let thirdPhotoName = BehaviorSubject<String?>(value: "")
        // let thirdPhoroFile = BehaviorSubject<Data?>(value: nil)
        
        let postDone = PublishSubject<Void>()
        
        var postBody: [String: Any] = [
            "title": "",
            "price": 0,
            "content": "",
            "major": "",
            "location": "",
            "type": "",
            "topic": "",
        ]
        
        /// 레슨 제목
        input.titleText.orEmpty
            .map { titleText in
                return "\(titleText)"
            }
            .bind { titleText in
                postBody["title"] = titleText
            }
            .disposed(by: disposeBag)
        
        /// 레슨 가격
        input.priceText.orEmpty
            .map { priceText in
                return Int(priceText)
            }
            .bind { priceInt in
                postBody["price"] = priceInt
            }
            .disposed(by: disposeBag)
        
        /// 레슨 과목 필드 탭 - 레슨 과목 픽커 열림
        input.majorFieldTap
            .bind { _ in
                majorList.onNext(Constant.Lesson.major)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 과목 선택
        input.majorSelect
            .bind { selected in
                selectedMajor.onNext(selected.first)
            }
            .disposed(by: disposeBag)
        
        input.majorSelect
            .map { selected in
                return selected.first
            }
            .bind { selected in
                postBody["major"] = selected
            }
            .disposed(by: disposeBag)
        
        /// 레슨 위치 필드 탭 - 레슨 위치 픽커 열림
        input.locationFieldTap
            .bind { _ in
                locationList.onNext(Constant.Lesson.location)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 위치 선택
        input.locationSelect
            .bind { selected in
                selectedLocation.onNext(selected.first)
            }
            .disposed(by: disposeBag)
        
        input.locationSelect
            .map { selected in
                return selected.first
            }
            .bind { selected in
                postBody["location"] = selected
            }
            .disposed(by: disposeBag)
        
        /// 레슨 타입 필드 탭 - 레슨 타입 픽커 열림
        input.typeFieldTap
            .bind { _ in
                typeList.onNext(Constant.Lesson.type)            }
            .disposed(by: disposeBag)
        
        /// 레슨 타입 선택
        input.typeSelect
            .bind { selected in
                selectedType.onNext(selected.first)
            }
            .disposed(by: disposeBag)
        
        input.typeSelect
            .map { selected in
                return selected.first
            }
            .bind { selected in
                postBody["type"] = selected
            }
            .disposed(by: disposeBag)
        
        /// 레슨 소개
        input.contentText.orEmpty
            .map { contentText in
                return "\(contentText)"
            }
            .bind { contentText in
                postBody["content"] = contentText
            }
            .disposed(by: disposeBag)
        
        /// 이미지 선택과 파일명은 항상 같이 전달되므로 두 개의 이벤트가 다시 발생할 때만 사용 -> Zip
        let photoData = Observable.zip([
            input.firstPhoroFile,
            input.secondPhotoFile,
            input.thirdPhoroFile
        ])
        
        let photoName = Observable.zip([
            input.firstPhotoName,
            input.secondPhotoName,
            input.thirdPhotoName
        ])
        
        let photoInfo = Observable.zip(photoData, photoName)
        
        let files = PublishSubject<[String]>()
        
        /// 레슨 개설 버튼 탭 - 파일 업로드 & 게시물 업로드
        input.postButtonTap
            .withLatestFrom(photoInfo)
            .flatMap { info in
                let datas = info.0
                let fileNames = info.1
                return NetworkManager.shared.uploadFiles(files: datas, fileNames: fileNames)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    files.onNext(value.files)
                    print(value.files)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        files
            .flatMap { files in
                let body = PostBody(
                    title: postBody["title"] as? String ?? "Untitled",
                    price: postBody["price"] as? Int ?? 0,
                    content: postBody["content"] as? String ?? "",
                    content1: postBody["major"] as? String ?? "",
                    content2: postBody["location"] as? String ?? "",
                    content3: postBody["type"] as? String ?? "",
                    content4: "",
                    content5: "",
                    product_id: ProductId.defaultId,
                    files: files)
                return NetworkManager.shared.apiCall(api: .post(.posts(body: body)), of: Post.self)
            }
            .bind { result in
                postDone.on(.completed)
                switch result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(majorList: majorList,
                      selectedMajor: selectedMajor,
                      locationList: locationList,
                      selectedLocation: selectedLocation,
                      typeList: typeList,
                      selectedType: selectedType, 
                      photoButtonTap: input.photoButtonTap, 
                      postDone: postDone)
    }
    
}
