//
//  CoreDataManager.swift
//  Muda
//
//  Created by Bowon Han on 8/1/24.
//

import Foundation
import CoreData

final class CoreDataManager {
    private init() {}
    
    static let shared: CoreDataManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "DiaryCoreData")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      })
      return container
    }()
    
    // MARK: - core data에 데이터 저장 로직
    func saveData(with diaryData: DiaryModel) {
        print("coredata 저장됨")
        let viewContext = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Diary", in: viewContext)
        
        guard let entity = entity else { return }
        let diary = NSManagedObject(entity: entity, insertInto: viewContext)
        diary.setValue(diaryData.id, forKey: "id")
        diary.setValue(diaryData.title, forKey: "title")
        diary.setValue(diaryData.singer, forKey: "singer")
        diary.setValue(diaryData.imageName, forKey: "imageName")
        diary.setValue(diaryData.diary, forKey: "diary")
        diary.setValue(diaryData.date, forKey: "date")
        diary.setValue(diaryData.color?.toString(), forKey: "color")
        diary.setValue(diaryData.isLike, forKey: "isLike")
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    // MARK: - core data에 저장된 내용을 불러와 [DiaryModel로 반환]
    func fetchData() -> [DiaryModel]? {
        let context = self.persistentContainer.viewContext
        var diaryModels: [DiaryModel] = []
        
        do {
            let request = Diary.fetchRequest()
            request.returnsObjectsAsFaults = false
            
            let diary = try context.fetch(request)
            
            diary.forEach {
                if let id = $0.id,
                   let title = $0.title,
                   let imageName = $0.imageName,
                   let singer = $0.singer,
                   let diary = $0.diary,
                   let date = $0.date,
                   let color = $0.color {
                    diaryModels.append(DiaryModel(id: id,
                                                  title: title,
                                                  imageName: imageName,
                                                  singer: singer,
                                                  diary: diary,
                                                  date: date,
                                                  color: ColorsType.stringToType(color),
                                                  isLike: $0.isLike))
                }
            }
            
            return diaryModels
        } catch {
            fatalError("\(error)")
        }
    }
    
    // MARK: - core data의 내용 변경(update)
    func updateData(with diaryData: DiaryModel) {
        let context = self.persistentContainer.viewContext
        let request = Diary.fetchRequest()
        request.returnsObjectsAsFaults = false

        do {
            let diary = try context.fetch(request)
            let filteredDiary = diary.filter({ $0.id == diaryData.id })
                        
            filteredDiary.forEach {
                $0.diary = diaryData.diary
                $0.date = diaryData.date
                $0.color = diaryData.color?.toString()
            }
            
            try context.save()
        } catch  {
            fatalError()
        }
    }
}
