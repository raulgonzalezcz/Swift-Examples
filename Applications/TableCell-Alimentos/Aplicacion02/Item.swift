//Librerìa importada
import Foundation

//Clase Elemento
class Item: NSObject{
    //Variables
    var name: String
    var value: Int
    var serialNumber: String?
    //Costante
    let dateCreated: Date
    
    //Sobreescritura de inicialziación
    override init() {
        //Variables
        var random: RandomInt
        var randomSerialNumber: String
        var universalyUniqueId: UUID
        var randomAdjective: String
        var randomNoun: String
        var randomName: String
        //Constantes
        let adjectives = ["Ricos", "Auténticos", "Nuevos", "Tradicionales"]
        let nouns = ["Tacos", "Tamales", "Chilaquiles", "Molotes", "Tlacoyos", "Espaguetis con atún"]
        //Declaraciones
        random = RandomInt(lessThan: adjectives.count)
        randomAdjective = adjectives[random.value]
        random = RandomInt(lessThan: nouns.count)
        randomNoun = nouns[random.value]
        randomName = "\(randomAdjective) \(randomNoun)"
        name = randomName
        
        //
        universalyUniqueId = UUID()
        randomSerialNumber = universalyUniqueId.uuidString.components(separatedBy: "-").first!
        serialNumber = randomSerialNumber
        random = RandomInt(lessThan: 40)
        value = random.value + 10
        
        dateCreated = Date()
    }
}
