
import UIKit
import  CoreData

class HomeTableViewController: UITableViewController, UISearchBarDelegate, NSFetchedResultsControllerDelegate{
    
    //MARK: - Variáveis
    
    let searchController = UISearchController(searchResultsController: nil)
    var gerenciadorResultados: NSFetchedResultsController<Aluno>?
    var alunoViewController: AlunoViewController?
    var mensagem = Mensagem()
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
            alunoViewController = segue.destination as? AlunoViewController
        }
    }
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
        gerenciadorResultados?.delegate = self
        
        do{
            try gerenciadorResultados?.performFetch()
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    //metodo abrir o longpress
    @objc func abrirActionSheet(_ longPress: UILongPressGestureRecognizer){
        if longPress.state == .began{
            guard let alunoSelecionado = gerenciadorResultados?.fetchedObjects?[(longPress.view?.tag)!] else { return  }
            let menu = MenuOpcoesAluno().configuraMenuDeOpcoesAluno(completion: { (opcao) in
                switch opcao{
                case .sms:
                    if let componenteMessagem = self.mensagem.configuraSMS(alunoSelecionado){
                        componenteMessagem.messageComposeDelegate = self.mensagem
                        self.present(componenteMessagem, animated: true, completion: nil)
                    }
                    break
                case.ligacao:
                    guard let numeroDoAluno = alunoSelecionado.telefone else { return }
                    if let url = URL(string: "tel://\(numeroDoAluno)"), UIApplication.shared.canOpenURL(url){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    break
                }
            })
            self.present(menu, animated: true, completion: nil)
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contadorListaDeAlunos = gerenciadorResultados?.fetchedObjects?.count
            else { return 0 }
        return contadorListaDeAlunos
    }
    //CRIA A CELULA
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "celula-aluno", for: indexPath) as! HomeTableViewCell
      //Cria o longpress dentro da celula
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(abrirActionSheet(_:)))
        
        guard let aluno = gerenciadorResultados?.fetchedObjects![indexPath.row]else
        {return celula}
        celula.configuraCelula(aluno)
        celula.addGestureRecognizer(longPress)
      
     

        return celula
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let alunoSelecionado = gerenciadorResultados?.fetchedObjects![indexPath.row] else{ return}
            contexto.delete(alunoSelecionado)
            do{
                try contexto.save()
                
            }catch{
                print(error.localizedDescription)
            }
           
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let alunoSelecionado = gerenciadorResultados?.fetchedObjects![indexPath.row] else { return  }
        alunoViewController?.aluno = alunoSelecionado
    }
    // MARK: - FetchedResultsControllerDelegate
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return  }
             tableView.deleteRows(at: [indexPath], with: .fade)
            break
            
            
        default:
            tableView.reloadData()
        }
    }
}
