
import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var mapa: MKMapView!
    
    //MARK: -Variavel
    
    var aluno: Aluno?
    lazy var localizacao = Localizacao()
    
    //MARK: - ViewLifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        localizacaoInicial()
        localizarAluno()
        mapa.delegate = localizacao
        
    }
    
    //MARK: -Metodos
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
    func localizacaoInicial(){
        Localizacao().converteEnderecoEmCoordenadas(endereco: "Caelum - SP") { (localizacaoEncontrada) in
            let pino = Localizacao().configuraPino(titulo: "Caelum", localizacao: localizacaoEncontrada, cor: .black, icone: nil)
            let regiao = MKCoordinateRegionMakeWithDistance(pino.coordinate, 5000, 5000)
            self.mapa.setRegion(regiao, animated: true)
            self.mapa.addAnnotation(pino)
            
        }
    }
    func localizarAluno(){
        if let aluno = aluno {
            
            Localizacao().converteEnderecoEmCoordenadas(endereco: aluno.endereco!) { (localizacaoEncontrada
                ) in
                let pino = Localizacao().configuraPino(titulo: aluno.nome!, localizacao: localizacaoEncontrada, cor: nil, icone: nil)
                self.mapa.addAnnotation(pino)
            }
            
        }
    }
   
}

