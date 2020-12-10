import Foundation

enum DrivingError: String, Error {
    case noLicense = "Прав нет в наличии!"
    case alcoholPresence = "В крови присутствует алкоголь!"
}

class Driver {
    var hasLicense = false
    var alcoholPresence = false
    
    func drive(speed: Double, time: Double) throws -> Double {
        if !hasLicense { throw DrivingError.noLicense }
        return speed * time
    }
}

let driver = Driver()

do {
    let distance = try driver.drive(speed: 10.0, time: 10.0)
    print(distance)
} catch {
    if error is DrivingError {
        let error = error as! DrivingError
        print(error.rawValue)
    }
}
