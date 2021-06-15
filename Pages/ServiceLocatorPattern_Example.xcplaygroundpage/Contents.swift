import Foundation


protocol Database{
    func fetch()-> String
}
final class DatabaseImplementation: Database {
    func fetch() -> String {
       print("Data Fetched Successfully")
        return "Mo saber Fares"
    }
}

protocol DatabaseLocator{
    func database()-> Database
}
extension DatabaseLocator{
    func database()-> Database{
        DatabaseImplementation()
    }
}
protocol CoreData{
    func saveData(data: String)
}

final class CoreDataImplementation: CoreData{
    func saveData(data: String) {
        print("\(data) data Saved Sucessfully")
    }
}

protocol CoreDataLocator{
    func coreData() -> CoreData
}

extension CoreDataLocator{
    func coreData() -> CoreData{
        CoreDataImplementation()
    }
}

class DataManager{
    typealias ServiceLocator = DatabaseLocator & CoreDataLocator
    final class ServiceLocatorImplemntaion: ServiceLocator{}
    
    private let database: Database
    private let coreData: CoreData
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImplemntaion() ) {
        self.database = serviceLocator.database()
        self.coreData = serviceLocator.coreData()
    }
    
    func fetch()-> String{
        database.fetch()
    }
    func save(data: String){
        coreData.saveData(data: data)
    }
}

let dataMAnager = DataManager()
let data = dataMAnager.fetch()
dataMAnager.save(data: data)

