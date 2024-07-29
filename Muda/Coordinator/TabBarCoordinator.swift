//
//  TabBarCoordinator.swift
//  Muda
//
//  Created by Bowon Han on 7/29/24.
//

import UIKit

final class TabBarCoordinator : Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    func start() {
        /// tabBar item 리스트
        let pages: [TabBarItemType] = TabBarItemType.allCases
        /// 각각의 tabBarItem 생성하기
        let tabBarItems: [UITabBarItem] = pages.map { self.createTabBarItem(of: $0) }
        /// 탭바별로 navigationController 생성
        let controllers: [UINavigationController] = tabBarItems.map {
            self.createTabNavigationController(tabBarItem: $0)
        }
        /// 탭바별로 코디네이터 생성
        let _ = controllers.map{ self.startTabCoordinator(tabNavigationController: $0) }
        /// 탭바 스타일 지정 및 VC 연결
        self.configureTabBarController(tabNavigationControllers: controllers)
        /// 탭바 화면에 연결
        self.addTabBarController()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.isNavigationBarHidden = true
        
        self.tabBarController = UITabBarController()
    }
    
    // MARK: - tabBarController 설정 메서드
    private func configureTabBarController(tabNavigationControllers: [UIViewController]) {
        /// TabBar의 VC 지정
        self.tabBarController.setViewControllers(tabNavigationControllers, animated: false)
        /// home의 index로 TabBar Index 세팅
        self.tabBarController.selectedIndex = TabBarItemType.diaryList.toInt()
        /// TabBar 스타일 지정
        
        let appearance = UITabBarAppearance()
        /// set tabbar opacity
        appearance.configureWithOpaqueBackground()
        
        /// remove tabbar border line
        appearance.shadowColor = UIColor.clear
        
        self.tabBarController.tabBar.standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            /// set tabbar opacity
            self.tabBarController.tabBar.scrollEdgeAppearance = self.tabBarController.tabBar.standardAppearance
        }
        
        /// set tabbar shadow
        self.tabBarController.tabBar.layer.masksToBounds = false
        self.tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        self.tabBarController.tabBar.layer.shadowOpacity = 0.1
        self.tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBarController.tabBar.layer.shadowRadius = 6
        
        self.tabBarController.tabBar.tintColor = .fourth
    }
    
    private func addTabBarController(){
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
    
    private func createTabBarItem(of page: TabBarItemType) -> UITabBarItem {
        return UITabBarItem(
            title: page.toKrName(),
            image: UIImage(systemName: page.toIconName()),
            tag: page.toInt()
        )
    }
    
    private func createTabNavigationController(tabBarItem: UITabBarItem) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.navigationBar.topItem?.title = TabBarItemType(index: tabBarItem.tag)?.toKrName()
        tabNavigationController.tabBarItem = tabBarItem
        
        return tabNavigationController
    }
    
    private func startTabCoordinator(tabNavigationController: UINavigationController) {
        // tag 번호로 TabBarPage로 변경
        let tabBarItemTag: Int = tabNavigationController.tabBarItem.tag
        guard let tabBarItemType: TabBarItemType = TabBarItemType(index: tabBarItemTag) else { return }
        
        // 코디네이터 생성 및 실행
        switch tabBarItemType {
        case .diaryList:
            let diaryListCoordinator = DiaryListCoordinator(navigationController: tabNavigationController)
            diaryListCoordinator.parentCoordinator = parentCoordinator
            
            parentCoordinator?.childCoordinator.append(diaryListCoordinator)
            diaryListCoordinator.start()
            
        case .musicList:
            let musicListCoordinator = MusicListCoordinator(navigationController: tabNavigationController)
            musicListCoordinator.parentCoordinator = parentCoordinator
            
            parentCoordinator?.childCoordinator.append(musicListCoordinator)
            musicListCoordinator.start()
        }
    }
}
