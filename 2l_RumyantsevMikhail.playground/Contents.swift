import Foundation

// 1. Функция, определяющая чётное число или нет

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

// 2. Функция, определяющая делится ли число без остатка на 3

func isDivisibleByThree(number: Int) -> Bool {
    return number % 3 == 0
}

// 3. Функция, создающая возрастающий массив из 100 чисел

func createAscendingArray(firstNumber: Int) -> [Int] {
    var result = [Int]()
    for number in firstNumber ..< firstNumber + 100 {
        result.append(number)
    }
    return result
}

var ascendingArray: [Int] = createAscendingArray(firstNumber: 3)

print("Возрастающий массив из 100 чисел:\n\(ascendingArray)")

// 4. Удалить из предыдущего массива все чётные числа и все числа, которые не делятся на 3

print("=================================")

let filteredArray = ascendingArray.filter { !isEven(number: $0) && isDivisibleByThree(number: $0) }

print("Возрастающий массив, из которого удалены все чётные числа и неделящиеся на 3:\n\(filteredArray)")
