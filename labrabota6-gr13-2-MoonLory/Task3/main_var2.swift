import Foundation
print("Введите двузначное число")
guard let input1 = readLine(),
    let n = Int(input1) else {
        print("Неверный ввод. Повторите попытку")
        exit(0)
}
print("Введите число a")
guard let input2 = readLine(),
    let a = Int(input2) else {
        print("Неверный ввод. Повторите попытку")
        exit(0)
}
if n%10 == a||n/10 == a {
    print ("Цифра ",a," встречается!")
} else  {
    print ("Цифра ",a," не встречается!")
}
