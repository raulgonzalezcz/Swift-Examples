//Librerìas importadas
import UIKit

class ViewController: UIViewController {

    //@IB Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    //@IB Actions
    @IBAction func insert(_ sender: Any) {
        Model.insertInto(name: nameTextField.text!, age: ageTextField.text!)
    }
    
    //Funciones de sobreescritura:
    //Vista cargada
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.createDB("db01")
        Model.openDB()
        Model.execute("CREATE TABLE IF NOT EXISTS Estudiantes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
