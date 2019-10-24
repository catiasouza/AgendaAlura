
import UIKit

class MapaViewController: UIViewController {
    
    //MARK: -Variavel
    
    var aluno: Aluno?
    
    //MARK: - ViewLifecicle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        print(aluno?.nome as Any)
    }
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
   
}
 
