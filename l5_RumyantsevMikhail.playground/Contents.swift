import Foundation

/*
    1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
    2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
    3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
    4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
    5. Создать несколько объектов каждого класса. Применить к ним различные действия.
    6. Вывести сами объекты в консоль.
 */

enum Brand {
    case BMW, Mercedes, Lada, Honda
}
enum VolumeAction {
    case load, unload
}

enum CarAction {
    case changeEngineState
    case changeWindowState
    case changeSpoilerState
    case changeVolume(action: VolumeAction, kg: UInt)
}

protocol Car: AnyObject {
    var brand: Brand { get }
    var productionYear: UInt { get }
    var engineState: Bool { get set }
    var windowState: Bool { get set }
    
    func runAction(carAction: CarAction)
}

extension Car {
    func changeEngineState() {
        self.engineState = !self.engineState
    }
    
    func changeWindowState() {
        self.windowState = !self.windowState
    }
}

class SportCar: Car {
    var brand: Brand
    var productionYear: UInt
    var engineState: Bool
    var windowState: Bool
    var spoilerState: Bool
    
    init(brand: Brand, productionYear: UInt, spoilerState: Bool) {
        self.brand = brand
        self.productionYear = productionYear
        self.spoilerState = spoilerState
        self.engineState = false
        self.windowState = false
    }
    
    func runAction(carAction: CarAction) {
        switch(carAction) {
        case .changeEngineState:
            self.changeEngineState()
            
        case .changeWindowState:
            self.changeWindowState()
            
        case .changeVolume(_, _):
            print("ВНИМАНИЕ: В спортивную машину нельзя ничего загрузить!")
            
        case .changeSpoilerState:
            self.spoilerState = !self.spoilerState
        }
    }
}

class TrunkCar: Car {
    var brand: Brand
    var productionYear: UInt
    var engineState: Bool
    var windowState: Bool
    var volume: UInt
    var loadedVolume: UInt
    
    init(brand: Brand, productionYear: UInt, volume: UInt) {
        self.brand = brand
        self.productionYear = productionYear
        self.volume = volume
        self.loadedVolume = 0
        self.engineState = false
        self.windowState = false
    }
    
    func runAction(carAction: CarAction) {
        switch(carAction) {
        case .changeEngineState:
            self.changeEngineState()
            
        case .changeWindowState:
            self.changeWindowState()
            
        case .changeVolume(let state, let kg):
            switch (state) {
            case .load:
                guard self.loadedVolume + kg <= volume else {
                    print("ВНИМАНИЕ: В машину нельзя загрузить больше \(self.volume - self.loadedVolume) кг!")
                    self.loadedVolume = volume
                    return
                }
                self.loadedVolume += kg
                
            case .unload:
                guard self.loadedVolume >= kg else {
                    print("ВНИМАНИЕ: Вы пытаетесь выгрузить из машины вес, больше имеющегося!")
                    self.loadedVolume = 0
                    return
                }
                self.loadedVolume -= kg
            }
            
        case .changeSpoilerState:
            print("ВНИМАНИЕ: На грузовик нельзя установить спойлер!")
        }
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        return "Brand: \(brand), production year: \(productionYear), engine: \(engineState ? "running" : "off"), windows: \(windowState ? "opened" : "closed"), spoiler: \(spoilerState ? "installed" : "off")."
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return "Brand: \(brand), production year: \(productionYear), engine: \(engineState ? "running" : "off"), windows: \(windowState ? "opened" : "closed"), volume: \(volume), loaded volume: \(loadedVolume)."
    }
}

var hondaSport = SportCar(brand: .Honda, productionYear: 2020, spoilerState: true)
var mercedesTrunk = TrunkCar(brand: .Mercedes, productionYear: 2015, volume: 4000)
var bmwSport = SportCar(brand: .BMW, productionYear: 2017, spoilerState: false)
var hondaTruck = TrunkCar(brand: .Honda, productionYear: 2018, volume: 2000)

hondaSport.runAction(carAction: .changeEngineState)
hondaSport.runAction(carAction: .changeVolume(action: .load, kg: 10))
hondaSport.changeWindowState()
print(hondaSport)

mercedesTrunk.runAction(carAction: .changeVolume(action: .load, kg: 2000))
mercedesTrunk.changeEngineState()
mercedesTrunk.runAction(carAction: .changeSpoilerState)
print(mercedesTrunk)

bmwSport.runAction(carAction: .changeSpoilerState)
bmwSport.runAction(carAction: .changeEngineState)
bmwSport.runAction(carAction: .changeWindowState)
print(bmwSport)

hondaTruck.changeEngineState()
hondaTruck.changeWindowState()
hondaTruck.runAction(carAction: .changeVolume(action: .unload, kg: 1000))
print(hondaTruck)
