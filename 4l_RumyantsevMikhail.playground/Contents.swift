import Foundation

/*
    1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
    2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
    3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
    4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    5. Создать несколько объектов каждого класса. Применить к ним различные действия.
    6. Вывести значения свойств экземпляров в консоль.
 */

enum Brand {
    case BMW, Mercedes, Lada, Honda
}
enum EngineState {
    case start, stop
}
enum WindowState {
    case open, close
}
enum SpoilerState {
    case on, off
}
enum VolumeAction {
    case load, unload
}

enum CarAction {
    case changeEngineState(state: EngineState)
    case changeWindowState(state: WindowState)
    case changeSpoilerState(state: SpoilerState)
    case changeVolume(action: VolumeAction, kg: UInt)
}

class Car {
    let brand: Brand
    let productionYear: UInt
    var engineState: EngineState
    var windowState: WindowState
    
    init(brand: Brand, productionYear: UInt) {
        self.brand = brand
        self.productionYear = productionYear
        self.engineState = .stop
        self.windowState = .close
    }
    
    func runAction(carAction: CarAction) {}
    
    func describeYourself() {
        print("Brand: \(brand), production year: \(productionYear), engine: \(self.engineState == .start ? "running" : "off"), windows: \(self.windowState == .open ? "opened" : "closed")")
    }
}

class SportCar: Car {
    var spoilerState: SpoilerState

    init(brand: Brand, productionYear: UInt, spoilerState: SpoilerState) {
        self.spoilerState = spoilerState
        super.init(brand: brand, productionYear: productionYear)
    }
    
    override func runAction(carAction: CarAction) {
        switch(carAction) {
        case .changeEngineState(let state):
            guard self.engineState != state else {
                print("Двигатель уже \(self.engineState == .start ? "запущен" : "выключен")")
                return
            }
            self.engineState = state

        case .changeWindowState(let state):
            guard self.windowState != state else {
                print("Окна уже \(self.windowState == .open ? "открыты" : "закрыты")")
                return
            }
            self.windowState = state

        case .changeVolume(_, _):
            print("В спортивную машину нельзя ничего загрузить!")

        case .changeSpoilerState(state: let state):
            guard self.spoilerState != state else {
                print("Спойлер уже \(self.spoilerState == .on ? "установлен" : "снят")")
                return
            }
            self.spoilerState = state
        }
    }

    override func describeYourself() {
        super.describeYourself()
        print("spoiler: \(self.spoilerState)")
    }
}

class TrunkCar: Car {
    var volume: UInt
    var loadedVolume: UInt
    
    init(brand: Brand, productionYear: UInt, volume: UInt) {
        self.volume = volume
        self.loadedVolume = 0
        super.init(brand: brand, productionYear: productionYear)
    }
    
    override func runAction(carAction: CarAction) {
        switch(carAction) {
        case .changeEngineState(let state):
            guard self.engineState != state else {
                print("Двигатель уже \(self.engineState == .start ? "запущен" : "выключен")")
                return
            }
            self.engineState = state

        case .changeWindowState(let state):
            guard self.windowState != state else {
                print("Окна уже \(self.windowState == .open ? "открыты" : "закрыты")")
                return
            }
            self.windowState = state

        case .changeVolume(let state, let kg):
            switch (state) {
            case .load:
                guard self.loadedVolume + kg <= volume else {
                    print("В машину нельзя загрузить больше \(self.volume - self.loadedVolume) кг!")
                    self.loadedVolume = volume
                    return
                }
                self.loadedVolume += kg

            case .unload:
                guard self.loadedVolume >= kg else {
                    print("Вы пытаетесь выгрузить из машины вес, больше имеющегося!")
                    self.loadedVolume = 0
                    return
                }
                self.loadedVolume -= kg
            }
            
        case .changeSpoilerState(_):
            print("На грузовик нельзя установить спойлер!")
        }
    }

    override func describeYourself() {
        super.describeYourself()
        print("volume: \(volume), loaded volume: \(loadedVolume)")
    }
}

var sportBmw = SportCar(brand: .BMW, productionYear: 2019, spoilerState: .on)
var trunkMercedes = TrunkCar(brand: .Mercedes, productionYear: 2020, volume: 3000)

sportBmw.runAction(carAction: .changeEngineState(state: .stop))
sportBmw.runAction(carAction: .changeEngineState(state: .start))
sportBmw.runAction(carAction: .changeWindowState(state: .close))
sportBmw.runAction(carAction: .changeVolume(action: .load, kg: 5))
sportBmw.runAction(carAction: .changeSpoilerState(state: .on))
sportBmw.describeYourself()

trunkMercedes.runAction(carAction: .changeVolume(action: .load, kg: 2100))
trunkMercedes.runAction(carAction: .changeVolume(action: .unload, kg: 100))
trunkMercedes.runAction(carAction: .changeVolume(action: .unload, kg: 150))
trunkMercedes.runAction(carAction: .changeEngineState(state: .start))
trunkMercedes.runAction(carAction: .changeSpoilerState(state: .on))
trunkMercedes.describeYourself()
