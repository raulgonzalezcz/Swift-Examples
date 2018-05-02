//Liberías importadas
import SQLite3
import UIKit

//Clase modelo
class Model {
    //Variables estáticas
    static var dbPointer: OpaquePointer? = nil
    static var statemenetPointer: OpaquePointer? = nil
    static var dbURL: URL? = nil
    static var list = Array<Estudiante>()
    
    //Funciones públicas estáticas:
    //Crear la base de datos
    public static func createDB(_ aName: String){
        Model.dbURL = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false).appendingPathComponent(aName + ".sqlite")
        print("DB created at:")
        print(Model.dbURL!)
    }
    
    //Abrir la base de datos
    public static func openDB(){
        //Condición
        if sqlite3_open(Model.dbURL!.path, &Model.dbPointer) != SQLITE_OK{
            print("Error opening database.")
        }else{
            print("DB open.")
        }
    }
    
    //Ejecuta una consulta
    public static func execute(_ aQuery: String){
        //Variable
        var errorMessage: String
        //Condición
        if sqlite3_exec(Model.dbPointer, aQuery, nil, nil, nil) != SQLITE_OK{
            errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
            print("Error executing SQL Statement: \(errorMessage)")
        }else{
            print("SQL Statement excuted!")
            print(aQuery)
        }
    }
    
    //Insertar dentro de la tabla
    public static func insertInto(name: String, age: String){
        //Variables
        let insertQuery = "INSERT INTO Estudiantes (name, age) VALUES (?, ?)"
        var errorMessage: String
        //Primera condición
        if queryIsPrepared(query: insertQuery){
            //Segunda condición
            if sqlite3_bind_text(statemenetPointer, 1, name, -1, nil) != SQLITE_OK{
                errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
                print("Failure binding name: \(errorMessage)")
                return
            }else{
                print("Binding name value")
            }
            
            //Tercera condición
            if sqlite3_bind_int(statemenetPointer, 2, (age as NSString).intValue) != SQLITE_OK{
                errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
                print("Failure binding age: \(errorMessage)")
                return
            }else{
                print("Binding age value")
            }
            
            //Cuarta condición
            if sqlite3_step(statemenetPointer) != SQLITE_DONE{
                errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
                print("Failure inserting record: \(errorMessage)")
                return
            }else{
                print("Record inserted.")
            }
        }
    }
    
    //Seleccionar todos
    public static func selectAll(){
        //Variable
        let selectAllQuery = "SELECT * FROM Estudiantes"
        
        //Condición
        if queryIsPrepared(query: selectAllQuery){
            list = getResultSet()
        }
    }
    
    //Seleccionar todos
    public static func selectAllOrderedByName(){
        //Variable
        let selectAllOrderedQuery = "SELECT * FROM Estudiantes ORDER BY name"
        
        //Condición
        if queryIsPrepared(query: selectAllOrderedQuery){
            list = getResultSet()
        }
    }
    
    //Seleccionar un estudiante de acuerdo al nombre
    public static func selectFromEstudiantesWhere(name: String){
        //Variable
        let selectWhereQuery = "SELECT id, name, age FROM Estudiantes WHERE name = '" + name + "'"
        
        //Condición
        if queryIsPrepared(query: selectWhereQuery){
            list = getResultSet()
        }
    }
    
    //Eliminar este elemento de acuerdo al id
    public static func deleteFromEstudiantesWhere(id: String){
        //Variables
        let deleteWhereStatement = "DELETE FROM Estudiantes WHERE id = '" + id + "'"
        var errorMessage: String
        
        //Primera condición
        if queryIsPrepared(query: deleteWhereStatement){
            //Segunda condición
            if sqlite3_step(statemenetPointer) == SQLITE_DONE{
                print("Row deleted.")
            }else{
                errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
                print("Failure deleting record : \(errorMessage)")
            }
        }
    }
    
    //Eliminar todos los elementos
    public static func deleteFromEstudiantes(){
        //Variables
        let deleteAllStatement = "DELETE FROM Estudiantes"
        var errorMessage: String
        
        //Primera condición
        if queryIsPrepared(query: deleteAllStatement){
            //Segunda condición
            if sqlite3_step(statemenetPointer) == SQLITE_DONE{
                print("All records deleted.")
            }else{
                errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
                print("Failure deleting all records: : \(errorMessage)")
            }
        }
    }
    
    //Funciones privadas estáticas:
    //Obtener el resultado establecido
    private static func getResultSet() -> Array<Estudiante>{
        //Variables
        var resultSet: Array<Estudiante>
        var id: Int32
        var nombre: String
        var edad: Int32
        
        //
        resultSet = []
        //Ciclo para recuperar todas las grabaciones
        while(sqlite3_step(statemenetPointer) == SQLITE_ROW){
            id = sqlite3_column_int(statemenetPointer, 0)
            nombre = String(cString: sqlite3_column_text(statemenetPointer, 1))
            edad = sqlite3_column_int(statemenetPointer, 2)
            //Agrega los objetos al reusltado establecido
            resultSet.append(Estudiante(Int(id), nombre, Int(edad)))
        }
        return resultSet
    }
    
    //La consulta está preparada
    private static func queryIsPrepared(query: String) -> Bool{
        //Variables
        var queryIsPrepared: Bool
        var errorMessage: String
        
        //
        queryIsPrepared = false
        
        //Condicion
        if sqlite3_prepare(dbPointer, query, -1, &statemenetPointer, nil) != SQLITE_OK{
            errorMessage = String(cString: sqlite3_errmsg(Model.dbPointer)!)
            print("Error preparing query: \(errorMessage)")
        }else{
            queryIsPrepared = true
        }
        return queryIsPrepared
    }
}
