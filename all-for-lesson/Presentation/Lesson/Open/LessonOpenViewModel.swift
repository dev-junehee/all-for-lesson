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
        let titleText: ControlProperty<String?>
        let priceText: ControlProperty<String?>
        let majorFieldTap: ControlEvent<Void>
        let majorSelect: ControlEvent<[String]>
        let locationFieldTap: ControlEvent<Void>
        let locationSelect: ControlEvent<[String]>
        let typeFieldTap: ControlEvent<Void>
        let typeSelect: ControlEvent<[String]>
        let contentText: ControlProperty<String?>
        let photoButtonTap: ControlEvent<Void>
        let postButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let majorList: PublishSubject<[String]>
        let selectedMajor: PublishSubject<String?>
        let locationList: PublishSubject<[String]>
        let selectedLocation: PublishSubject<String?>
        let typeList: PublishSubject<[String]>
        let selectedType: PublishSubject<String?>
        let photoButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let majorList = PublishSubject<[String]>()
        let selectedMajor = PublishSubject<String?>()
        let locationList = PublishSubject<[String]>()
        let selectedLocation = PublishSubject<String?>()
        let typeList = PublishSubject<[String]>()
        let selectedType = PublishSubject<String?>()
        
        /// 레슨 과목 필드 탭 - 레슨 과목 픽커 열림
        input.majorFieldTap
            .bind { _ in
                majorList.onNext(Constant.Lesson.major)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    selectedMajor.onNext(Constant.Lesson.major.first)
                }
            }
            .disposed(by: disposeBag)
        
        /// 레슨 과목 선택
        input.majorSelect
            .bind { selected in
                selectedMajor.onNext(selected.first)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 위치 필드 탭 - 레슨 위치 픽커 열림
        input.locationFieldTap
            .bind { _ in
                locationList.onNext(Constant.Lesson.location)
                selectedLocation.onNext(Constant.Lesson.location.first)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 위치 선택
        input.locationSelect
            .bind { selected in
                selectedLocation.onNext(selected.first)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 타입 필드 탭 - 레슨 타입 픽커 열림
        input.typeFieldTap
            .bind { _ in
                typeList.onNext(Constant.Lesson.type)
                selectedType.onNext(Constant.Lesson.type.first)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 타입 선택
        input.typeSelect
            .bind { selected in
                selectedType.onNext(selected.first)
            }
            .disposed(by: disposeBag)

        /// 레슨 개설 버튼 탭
        input.postButtonTap
            .bind { _ in
                print("Test")
            }
            .disposed(by: disposeBag)
        
      
        
        return Output(majorList: majorList,
                      selectedMajor: selectedMajor,
                      locationList: locationList,
                      selectedLocation: selectedLocation,
                      typeList: typeList,
                      selectedType: selectedType, 
                      photoButtonTap: input.photoButtonTap)
    }
    
}
