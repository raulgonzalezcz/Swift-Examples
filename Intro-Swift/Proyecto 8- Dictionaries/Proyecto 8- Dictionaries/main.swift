//
//  main.swift
//  Proyecto 8- Dictionaries
//
//  Created by Manuel Escobar on 9/4/17.
//  Copyright © 2017 Manuel Escobar. All rights reserved.
//

var dictionary : [Int : String]
var value : String
var key : Int
var array : [String]
//


dictionary = [Int : String]() //invocando al contructor diccionario, este tipo de funcion es un constructor por que contruye al objeto llave = int valor = string
dictionary[11] = "oneOne"
dictionary[22] = "twoTwo"
dictionary[33] = "threeThree"
dictionary[44] = "fourFour"
dictionary[55] = "fiveFive"

print(dictionary)
print(dictionary.count)
print(dictionary.isEmpty)

//update value

dictionary.updateValue("sanSan", forKey: 33)
print(dictionary)


//remove value

//la constante que declaramos en el if let unicamente vive dentro del ciclo de vida del if, es completamente independiente de toso lo demas, value declarado como variable es diferente
if let value = dictionary.removeValue(forKey: 77)//la condicion es la declaracion de una constante, le estamos dando ese valor a la constante (funciona igual que con los sets)
{
    print(value)
}//en if
else
{
    print("The dictionary does not contain a valur for 77 to be removed")
}//end else

//para procesar todos y cada uno de los elemntos del diccionario usamos un for
for (key, value) in dictionary
{
    print("\(key): \(value)")
}//end for

for key in dictionary.keys // .keys es un arreglo de objetos de la clase correspondienta a la llave que hagamos indicado
{
    print(key)
}//end for

for value in dictionary.values
{
    print(value)
}//end for


//crate an Array
array = Array(dictionary.values) //necesitamos contruir el arreglo y mandarle el arreglo de values del diccionario
print(array)



































