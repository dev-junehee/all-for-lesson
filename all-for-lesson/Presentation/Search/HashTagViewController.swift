//
//  HashTagViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import Foundation
import RxCocoa
import RxSwift

final class HashTagViewController: BaseViewController {
    
    private let hashtagView = HashTagView()
    private let viewModel = HashTagViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = hashtagView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = HashTagViewModel.Input(
            searchText: hashtagView.searchTextField.rx.text, 
            searchButtonTap: hashtagView.searchButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        
        
    }
}
