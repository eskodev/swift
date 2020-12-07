import Foundation

class Queue<T> {
    private var array: [T] = []
    
    func pop() -> T? {
        guard array.count > 0 else { return nil }
        return array.removeFirst()
    }
    
    func push(_ elememt: T) {
        array.insert(elememt, at: 0)
    }
    
    func filter(closure: (T) -> Bool) -> [T] {
        var tempArray: [T] = []
        
        for value in self.array {
            if closure(value) {
                tempArray.insert(value, at: 0)
            }
        }
        
        return tempArray
    }
    
    subscript(index: Int) -> T? {
        guard index < self.array.count else { return nil }
        return array[index]
    }
}

var queueOfStrings = Queue<String>()
queueOfStrings.push("first")
queueOfStrings.push("second")
queueOfStrings.push("third")
queueOfStrings.push("fourth")
queueOfStrings.pop()

queueOfStrings[1]
queueOfStrings[10]

var newQueueOfStrings = queueOfStrings.filter { $0.contains("s") }
print(newQueueOfStrings)
