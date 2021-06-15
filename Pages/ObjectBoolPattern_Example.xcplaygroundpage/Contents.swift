import Foundation

class Book {
    let author: String
    let title: String
    let stockNumber: Int
    var reader: String?
    var checkoutCount = 0
    
    init(author: String, title: String, stockNumber: Int) {
        self.author = author
        self.stockNumber = stockNumber
        self.title = title
    }
}


class Pool<T> {
    private var data = [T]()
    private let serialQ = DispatchQueue(label: "Saber.serial.queue")
    let semaphore: DispatchSemaphore
    
    init(items: [T]) {
        data.reserveCapacity(items.count)
        semaphore = DispatchSemaphore(value: data.count)
        for item in items {
            data.append(item)
        }
    }
    
    func getFromPool() ->T?{
        semaphore.wait()
        serialQ.sync {
            return self.data[0]

            }
    return nil
    
}
    func returnToPool(item: T){
        serialQ.async {
            self.data.append(item)
            self.semaphore.signal()
        }
    }
}


class Library {
    private var books: [Book]
    private var pool : Pool<Book>
    
}
