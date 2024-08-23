//
//  LessonOpenViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import UIKit
import PhotosUI
import RxCocoa
import RxSwift

final class LessonOpenViewController: BaseViewController {
    
    private let openView = LessonOpenView()
    private let viewModel = LessonOpenViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = openView
    }
    
    override func setViewController() {
        navigationItem.title = "새로운 레슨 개설하기"
        setImgBarButton(image: Resource.SystemImage.plus, target: self, action: nil, type: .right)
        openView.photoPicker.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        guard let postButton = navigationItem.rightBarButtonItem else { return }
        
        let input = LessonOpenViewModel.Input(
            titleText: openView.titleField.rx.text,
            priceText: openView.priceField.rx.text,
            majorFieldTap: openView.majorField.rx.controlEvent(.allEditingEvents),
            majorSelect: openView.majorPicker.rx.modelSelected(String.self),
            locationFieldTap: openView.locationField.rx.controlEvent(.allEditingEvents),
            locationSelect: openView.locationPicker.rx.modelSelected(String.self),
            typeFieldTap: openView.typeField.rx.controlEvent(.allEditingEvents),
            typeSelect: openView.typePicker.rx.modelSelected(String.self),
            contentText: openView.contentField.rx.text,
            photoButtonTap: openView.photoButton.rx.tap,
            postButtonTap: postButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
        
        /// 레슨 과목 데이터 바인딩
        output.majorList
            .bind(to: openView.majorPicker.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        /// 선택한 레슨 과목
        output.selectedMajor
            .bind(to: openView.majorField.rx.text)
            .disposed(by: disposeBag)
        
        /// 레슨 위치 데이터 바인딩
        output.locationList
            .bind(to: openView.locationPicker.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        /// 선택한 레슨 위치
        output.selectedLocation
            .bind(to: openView.locationField.rx.text)
            .disposed(by: disposeBag)
        
        /// 레슨 타입 데이터 바인딩
        output.typeList
            .bind(to: openView.typePicker.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        /// 선택한 레슨 타입
        output.selectedType
            .bind(to: openView.typeField.rx.text)
            .disposed(by: disposeBag)
        
        /// 사진 선택 버튼 탭 - 이미지 픽커 열림
        output.photoButtonTap
            .bind(with: self) { owner, _ in
                owner.present(owner.openView.photoPicker, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}

extension LessonOpenViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function, "111", Thread.isMainThread)
        
        if let firstProvider = results.first?.itemProvider, firstProvider.canLoadObject(ofClass: UIImage.self) {
            firstProvider.loadObject(ofClass: UIImage.self) { image, error in
                print(#function, "222", Thread.isMainThread)
                DispatchQueue.main.async {
                    self.openView.firstPhoto.image = image as? UIImage
                }
            }
        }
        
        if results.count > 1 {
            let secondProvider = results[1].itemProvider
            if secondProvider.canLoadObject(ofClass: UIImage.self) {
                secondProvider.loadObject(ofClass: UIImage.self) { image, error in
                    print(#function, "333", Thread.isMainThread)
                    DispatchQueue.main.async {
                        self.openView.secondPhoto.image = image as? UIImage
                    }
                }
            }
            
            if let thirdProvider = results.last?.itemProvider, thirdProvider.canLoadObject(ofClass: UIImage.self) {
                thirdProvider.loadObject(ofClass: UIImage.self) { image, error in
                    print(#function, "444", Thread.isMainThread)
                    DispatchQueue.main.async {
                        self.openView.thirdPhoto.image = image as? UIImage
                    }
                }
            }
        }
        
        picker.dismiss(animated: true)
    }
}
