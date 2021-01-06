import Foundation
print("Введите строку")
let response = readLine()

var myArray:[String] = response!.components(separatedBy: " ")
print (myArray.count," слов")

var wordCount = [String: Int]()

for word in myArray
{
    if (wordCount[word] == nil)
    {
        wordCount[word] = 0
    }
    wordCount[word] = wordCount[word]! + 1
}

let sortedArray = myArray.sorted 
{ 
    return $1 < $0
}

for word in sortedArray
{
    print(word, ": ", wordCount[word]!)
}
