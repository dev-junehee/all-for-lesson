//
//  LessonEditViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import UIKit
import RxCocoa
import RxSwift

final class LessonEditViewController: BaseViewController {
    
    private let myLessonEditView = LessonOpenView()
    private let viewModel = LessonEditViewModel()
    // private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func loadView() {
        view = myLessonEditView
    }
    
    override func setViewController() {
        navigationItem.title = "레슨 정보 수정"
        setTextBarButton(title: "수정", action: nil, type: .right)
    }
    
    private func bind() {
        let input = LessonEditViewModel.Input()
        let _ = viewModel.transform(input: input)
        
    }
    
    func updateLessonEditView(post: Post) {
        myLessonEditView.titleField.text = post.title
        myLessonEditView.priceField.text = "\(post.price)"
        myLessonEditView.majorField.text = post.content1
        myLessonEditView.locationField.text = post.content2
        myLessonEditView.typeField.text = post.content3
        myLessonEditView.contentField.text = post.content
        
        let images = post.files
        NetworkManager.shared.getImage(images[0]) { [weak self] data in
            self?.myLessonEditView.firstPhoto.image = UIImage(data: data)
        }
        NetworkManager.shared.getImage(images[1]) { [weak self] data in
            self?.myLessonEditView.secondPhoto.image = UIImage(data: data)
        }
        NetworkManager.shared.getImage(images[2]) { [weak self] data in
            self?.myLessonEditView.thirdPhoto.image = UIImage(data: data)
        }
       
    }
    
}
