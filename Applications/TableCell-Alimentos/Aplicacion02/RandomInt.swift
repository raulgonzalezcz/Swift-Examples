import Foundation
class RandomInt{
    var value : Int
    init(lessThan: Int){
        var randomNumber : UInt32
        randomNumber = arc4random_uniform(UInt32(lessThan))
        value = Int(randomNumber)
    }
}
