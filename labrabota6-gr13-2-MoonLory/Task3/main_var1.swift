
import Foundation
print("Введите число")
guard let input = readLine(),
    let n = Int(input) else {
        print("Неверный ввод. Повторите попытку")
        exit(0)
}
if n%10 == 5||n/10 == 5 {
    print ("Цифра 5 встречается!")
} else  {
    print ("Цифра 5 не встречается!")
} 
