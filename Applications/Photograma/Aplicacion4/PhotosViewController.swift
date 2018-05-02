//Libería importada
import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {

    //Variables
    var webServiceCallsHandler: WebServiceCallsHandler!
    let collectionViewDataSource = CollectionViewDataSource()
    
    //IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = self
        webServiceCallsHandler.fetchInterestingPhotos{
            (webServiceResult) -> Void
            in
            switch webServiceResult{
            case let .success(photos):
                print("Se obtuvieron \(photos.count) fotos del servicio web")
                self.collectionViewDataSource.photos = photos
            case let .failure(error):
                print("Error al solicitar fotos al servicio web: \(error)")
                self.collectionViewDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController : PhotoInfoViewController
        switch segue.identifier{
        case "showPhoto"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first{
                let photo = collectionViewDataSource.photos[selectedIndexPath.row]
                destinationViewController = segue.destination as! PhotoInfoViewController
                destinationViewController.photo = photo
                destinationViewController.handler = webServiceCallsHandler
            }
        default:
            preconditionFailure("Identificador de segue inesperado")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var photo : Photo
        photo = collectionViewDataSource.photos[indexPath.row]
        
        webServiceCallsHandler.fetchImage(for: photo, completion:{
            (result) -> Void
            in
            guard let photoIndex = self.collectionViewDataSource.photos.index(of: photo), case let .success(image) = result
            else{
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell{
                cell.update(with: image)
            }
        })
    }
    
    
}
