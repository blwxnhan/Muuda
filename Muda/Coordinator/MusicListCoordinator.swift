//
//  MusicListCoordinator.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit

final class MusicListCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    var presentedViewController: UIViewController? = nil
    
    var navigationController: UINavigationController

    func start() {
        presentMusicList()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.tintColor = .black
    }
}

extension MusicListCoordinator: MusicListViewControllerDelegate,
                                AddDiaryViewControllerDelegate {
    func presentMusicList() {
        let musicList = MusicListViewController()
        musicList.delegate = self
        navigationController.pushViewController(musicList, animated: true)
    }
    
    func presentAddDiary(viewModel: DiaryViewModel, type: AddType) {
        let addDiary = AddDiaryViewController(viewModel: viewModel, type: type)
        addDiary.delegate = self
        addDiary.modalPresentationStyle = UIModalPresentationStyle.automatic
        navigationController.present(addDiary, animated: true, completion: nil)
    }
    
    func backToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
