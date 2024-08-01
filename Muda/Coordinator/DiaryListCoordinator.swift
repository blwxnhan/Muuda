//
//  DiaryListCoordinator.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit

final class DiaryListCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var presentedViewController: UIViewController? = nil
    
    var navigationController: UINavigationController

    func start() {
        presentDiaryList()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = .black
    }
}

extension DiaryListCoordinator: DiaryListViewControllerDelegate,
                            DiaryViewControllerDelegate,
                            AddDiaryViewControllerDelegate {
    func presentDiaryList() {
        let diaryListVM = DiaryListViewModel(dataManager: DiaryListManager())
        let diaryList = DiaryListViewController(viewModel: diaryListVM)
        diaryList.delegate = self
        navigationController.pushViewController(diaryList, animated: true)
    }
    
    func presentDiary(viewModel: DiaryViewModel) {
        let diary = DiaryViewController()
        diary.viewModel = viewModel
        diary.delegate = self
        navigationController.pushViewController(diary, animated: true)
    }
    
    func presentAddDiary(viewModel: DiaryViewModel) {
        let addDiary = AddDiaryViewController(viewModel: viewModel)
        addDiary.delegate = self
        addDiary.modalPresentationStyle = UIModalPresentationStyle.automatic
        navigationController.present(addDiary, animated: true, completion: nil)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
