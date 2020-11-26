import Foundation

/*
    1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
    2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
    3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
    4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
    6. Вывести значения свойств экземпляров в консоль.
 */

enum Brand {
    case bmw
    case mercedes
    case lada
    case hyundai
}

enum EngineState {
    case start
    case stop
}

enum WindowState {
    case open
    case close
}

enum VolumeAction {
    case load
    case unload
}

enum CarAction {
    // Амир, ВОПРОС: Далее варианты enum. Какой тип данных у каждого варианта? Идёт название, затем скобка. Похоже на функцию.
    case changeEngineState(action: EngineState)
    case changeWindowState(action: WindowState)
    case changeVolume(action: VolumeAction, kg: UInt)
}

struct SportCar {
    let brand: Brand
    let productionYear: UInt
    var volume: UInt
    var engineState: EngineState
    var windowState: WindowState
    var loadedVolume: UInt
    
    mutating func runAction(carAction: CarAction) {
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
                    return
                }
                self.loadedVolume += kg
                
            case .unload:
                guard self.loadedVolume >= kg else {
                    print("Вы пытаетесь выгрузить из машины вес, больше имеющегося!")
                    return
                }
                self.loadedVolume -= kg
            }
        }
    }
    
    func describeYourself() {
        print("Brand: \(brand), production year: \(productionYear), volume: \(volume), loaded volume: \(loadedVolume), engine: \(self.engineState == .start ? "running" : "off"), windows: \(self.windowState == .open ? "opened" : "closed")")
    }
}

struct TrunkCar {
    let brand: Brand
    let productionYear: UInt
    var volume: UInt
    var engineState: EngineState
    var windowState: WindowState
    var loadedVolume: UInt
    
    mutating func runAction(carAction: CarAction) {
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
        }
    }
    
    func describeYourself() {
        print("Brand: \(brand), production year: \(productionYear), volume: \(volume), loaded volume: \(loadedVolume), engine: \(self.engineState == .start ? "running" : "off"), windows: \(self.windowState == .open ? "opened" : "closed")")
    }
}

var sportBmw = SportCar(brand: .bmw, productionYear: 2016, volume: 50, engineState: .start, windowState: .close, loadedVolume: 3)

var trunkMercedes = TrunkCar(brand: .mercedes, productionYear: 2019, volume: 2000, engineState: .stop, windowState: .open, loadedVolume: 1200)

sportBmw.runAction(carAction: .changeEngineState(action: .stop))
sportBmw.runAction(carAction: .changeEngineState(action: .stop))
sportBmw.runAction(carAction: .changeWindowState(action: .close))
sportBmw.runAction(carAction: .changeVolume(action: .load, kg: 5))
sportBmw.describeYourself()

trunkMercedes.runAction(carAction: .changeVolume(action: .load, kg: 900))
trunkMercedes.runAction(carAction: .changeVolume(action: .unload, kg: 100))
trunkMercedes.runAction(carAction: .changeVolume(action: .unload, kg: 2000))
trunkMercedes.runAction(carAction: .changeEngineState(action: .start))
trunkMercedes.describeYourself()
