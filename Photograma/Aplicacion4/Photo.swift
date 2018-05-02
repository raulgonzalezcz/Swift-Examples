//Libería Importada
import UIKit

//Clase foto
class Photo{
    //Variables
    var title: String
    var remoteURL: URL
    var photoID: String
    var dateTaken: Date
    
    //Inicializador
    init(title: String,
         photoID: String,
         remoteURL: URL,
         dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}

extension Photo:Equatable{
    static func == (lhs:Photo, rhs:Photo) -> Bool{
        //Rwo photos are teh same
        return lhs.photoID == rhs.photoID
    }
}
