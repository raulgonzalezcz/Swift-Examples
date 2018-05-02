//Librería importada
import UIKit

//Clase de la colección de fotos en una celda (vista)
class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    //IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        update(with: nil)
    }
    
    func update(with image: UIImage?){
        if let imageToDispay = image{
            spinner.stopAnimating()
            imageView.image = imageToDispay
        }else{
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
}
