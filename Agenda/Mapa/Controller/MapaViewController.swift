
import UIKit
import MapKit

class MapaViewController: UIViewController, CLLocationManagerDelegate{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var mapa: MKMapView!
    
    //MARK: -Variavel
    
    var aluno: Aluno?
    lazy var localizacao = Localizacao()
    lazy var gereciadorDeLocalizacao = CLLocationManager()
    
    //MARK: - ViewLifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = getTitulo()
        verficaLocalizacaoDoUsuario()
        localizacaoInicial()
        localizarAluno()
        mapa.delegate = localizacao
        gereciadorDeLocalizacao.delegate = self
        
    }
    
    //MARK: -Metodos
    
    func getTitulo() -> String {
        return "Localizar Alunos"
    }
    func verficaLocalizacaoDoUsuario(){
        if CLLocationManager.locationServicesEnabled(){
            switch CLLocationManager.authorizationStatus() {
                
            case .authorizedWhenInUse:
                let botao = Localizacao().configuraBotaoLocalizacao(mapa: mapa)
                mapa.addSubview(botao)
                gereciadorDeLocalizacao.startUpdatingLocation()
                
                break
            case .notDetermined:
                   gereciadorDeLocalizacao.requestWhenInUseAuthorization()
                break
                
            case .denied:
                break
            default:
                break
            }
        }
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
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            let botao = Localizacao().configuraBotaoLocalizacao(mapa: mapa)
            mapa.addSubview(botao)
            gereciadorDeLocalizacao.startUpdatingLocation()
        default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        print(locations)
    }
}

