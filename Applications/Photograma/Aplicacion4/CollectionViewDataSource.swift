//Librería importada
import UIKit

//Clase de la visa de la colección en la fuente de datos
class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    //Variable
    var photos: [Photo] = []
    
    //Funciones de la interfaz UICollectionViewDataSource:
    //Número de elementos en la sección
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    //Desde la celda para un elemento
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Constantes
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
}
