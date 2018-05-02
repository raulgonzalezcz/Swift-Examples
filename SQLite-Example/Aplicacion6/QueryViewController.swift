//Libería Importada
import UIKit

//Clase vista - controlador de la consulta
class QueryViewController: UIViewController {

    //@IB Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    //@IB Actions:
    //Hacer una consulta
    @IBAction func makeQuery(_ sender: Any) {
        Model.selectFromEstudiantesWhere(name: nameTextField.text!)
        showList()
        //Condición
        if (!Model.list.isEmpty) {
            idTextField.text = String(describing: Model.list.first!.id)
            ageTextField.text = String(describing: Model.list.first!.edad)
        }
    }
    
    //Eliminar todos
    @IBAction func deleteAll(_ sender: Any) {
        Model.deleteFromEstudiantes()
    }
    
    //Eliminar este
    @IBAction func deleteThis(_ sender: Any) {
        Model.deleteFromEstudiantesWhere(id: idTextField.text!)
    }
    
    //Mostrar todo
    @IBAction func showAll(_ sender: Any) {
        Model.selectAll()
        showList()
    }
    
    //Mostrar todo ordenado
    @IBAction func showAllOrdered(_ sender: Any) {
        Model.selectAllOrderedByName()
        showList()
    }
    
    //Funciones privadas:
    //Mostrar la lista
    private func showList(){
        print("===========")
        //Ciclo
        for estudiante in Model.list {
            print("ID: " + String(estudiante.id))
            print("Nombre: " + estudiante.nombre)
            print("Edad: " + String(estudiante.edad))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
