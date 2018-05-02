//Librería importada
import UIKit

//Clase mi almacén de imágenes
class MyImageStore {
    //Constante
    let cache = NSCache<NSString, UIImage>()
    
    //Funciones:
    //Obtiene la URL de la imagen
    func getImageURL(forkey key: String) -> URL {
        //Variables internas
        var directoriesUrls: Array<URL>
        var directoryUrl: URL
        //
        directoriesUrls = FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        directoryUrl = directoriesUrls.first!
        return directoryUrl.appendingPathComponent(key)
    }
    
    //Establecer la imagen
    func setImage(_ image: UIImage, forkey key: String){
        //Variable
        var imageURL: URL
        //
        cache.setObject(image, forKey: key as NSString)
        //Crea una URL completa para la imagen
        imageURL = getImageURL(forkey: key)
        
        //Enciende la imagen en un dato de tipo JPEG
        if let imageJPEGData = UIImageJPEGRepresentation(image, 0.5){
            //Intenta escribirlo en una URL completa
            let _ = try? imageJPEGData.write(to: imageURL, options: [NSData.WritingOptions.atomic])
        }
    }
    
    //Obtener la imagen
    func getImage(forKey key: String) -> UIImage? {
        //Variable
        var imageURL: URL
        
        //Condición
        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }
        else{
            imageURL = getImageURL(forkey: key)
            //Constante guardiana
            guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path)
            else{
                return nil
            }
            //Asigna el objeto al cache para que se recupere y regresa la imagen
            cache.setObject(imageFromDisk, forKey: key as NSString)
            return imageFromDisk
        }
    }
}
