//
//  main.swift
//  Proyecto 9- Funciones
//
//  Created by Manuel Escobar on 9/4/17.
//  Copyright © 2017 Manuel Escobar. All rights reserved.
// coppling and cohesion of functions
// cohesion y acoplamiento de funciones

var string : String
var integer : Int
var double : Double

func noResultNoParameters() //this is a procedure in computer science
{
    print("Hello!")
}//end noResultNoParameters

noResultNoParameters()

func oneResultNoParameters() -> String
{
    return "a value" //regresa un valor y termina la funcion
}//end oneResultNoParameters

string = oneResultNoParameters()
print(string)


func oneParameter(stringParameter : String)
{
    print(stringParameter)
}

//Omite obligatoriamente el argumento
func oneParameterOmitArgument(_ stringParameter:String){
    print(stringParameter)
}

string = "Success"

oneParameter(stringParameter: string)
oneParameterOmitArgument(string)

func moreParameters(stringParameter:String,integerParameter:Int){
    print(stringParameter)
    print(integerParameter)
}

func multipleReturn() -> (Int,Double){
    return(5,6.6)
}

var miDupla: (Int, Double)
miDupla=multipleReturn()
print(miDupla.1)

func nestedFunction(_ parameter:Int)->Int{
    var result:Int
    func internalFunction(_ aValue:Int)->Int{
        return aValue*10
    }
    result = internalFunction(parameter)
    return result
}

print(nestedFunction(10))

func factorial(_ parameter: Int)-> Int{
    func checkParam(_ param: Int) -> Int{
        if parameter==0{
            return 1
        }
        return parameter * factorial(parameter-1)
    }
    if parameter<0 || parameter>20{
        print("no se puede")
        return -1
    }else{
        return checkParam(parameter)
    }
}

print(factorial(10))

func optionalReturn(_ parameter:Int)->Int? {
    if(parameter<=20){
        return parameter * parameter
    }
    else{
        return nil
    }
}

var otroInteger:Int?
otroInteger = optionalReturn(4)
print(otroInteger!)
