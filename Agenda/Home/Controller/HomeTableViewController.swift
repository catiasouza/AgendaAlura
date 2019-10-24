
import UIKit
import  CoreData

class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    //MARK: - Variáveis
    
    let searchController = UISearchController(searchResultsController: nil)
    var gerenciadorResultados: NSFetchedResultsController<Aluno>?
    var contexto:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuraSearch()
        self.recuperaAluno()
    }
    
    // MARK: - Métodos
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    func recuperaAluno(){
        let pesquisaAluno: NSFetchRequest <Aluno> = Aluno.fetchRequest()
        let ordenaNome = NSSortDescriptor(key: "nome", ascending: true)
        pesquisaAluno.sortDescriptors = [ordenaNome]
        
        gerenciadorResultados = NSFetchedResultsController(fetchRequest: pesquisaAluno, managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try gerenciadorResultados?.performFetch()
            
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contadorListaDeAlunos = gerenciadorResultados?.fetchedObjects?.count
            else { return 0 }
        return contadorListaDeAlunos
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
        
        guard let aluno = gerenciadorResultados?.fetchedObjects![indexPath.row]else
        {return celula
                
        }
        celula.labelNomeDoAluno.text = aluno.nome
        
        if let imagenDoAluno = aluno.foto as? UIImage{
            celula.imageAluno.image = imagenDoAluno
        }

        return celula
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

}
