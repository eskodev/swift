import Foundation

// ========================
// 1. Решение квадратного уравнения
// ========================

let a = 2
let b = 16
let c = 4

print("Дано уравнение: \(a)x² + \(b)x + \(c) = 0")

// Необходимо вычислить дискриминант, потому что от его значения зависит количество решений уравнения
let d = b * b - 4 * a * c

if (d < 0) {
    print("Данное уравнение не имеет решений")
} else if (d == 0) {
    let x = -b/(2 * a)
    print("Решение уравнения: x = \(x)")
} else {
    let x1 = (-Double(b) + Double(d).squareRoot())/(2 * Double(a))
    let x2 = (-Double(b) - Double(d).squareRoot())/(2 * Double(a))
    print("Решения уравнения: x1 = \(x1), x2 = \(x2)")
}

// ========================
// 2. Даны катеты прямоугольного треугольника. Нахождение площади, периметра и гипотенузы
// ========================
print("========================")

let katet1 = 3.3
let katet2: Double = 5
print("Даны катеты прямоугольного треугольника: \(katet1) и \(katet2)")

let gipotenuza = (katet1 * katet1 + katet2 * katet2).squareRoot()
print("Гипотенуза: \(gipotenuza)")

let ploshad = katet1 * katet2 / 2
print("Площадь: \(ploshad)")

let perimetr = katet1 + katet2 + gipotenuza
print("Периметр: \(perimetr)")

// ========================
// 3. Есть сумма вклада в банк и годовой процент. Нахождение суммы вклада через 5 лет
// ========================
print("========================")

var vklad = 124504.34
let godovoiProcent = 0.08
print("Дана сумма вклада: \(vklad), и годовой процент: \(Int(godovoiProcent * 100))")

vklad *= (1 + 0.08 * 5)
print("Вклад через 5 лет будет равен \(round(vklad * 100)/100)")
