

import UIKit

enum MenuActionSheetAlunos {
    case sms
    case ligacao
    case waze
    case mapa
    case abrirPaginaWeb
}

class MenuOpcoesAluno: NSObject {
  
    func configuraMenuDeOpcoesAluno(completion:@escaping(_ opcao:MenuActionSheetAlunos) -> Void) -> UIAlertController{
        let menu = UIAlertController(title: "Atencao", message: "Escolha uma das opcoes abaixo", preferredStyle: .actionSheet)
        
        let sms = UIAlertAction(title: "Enviar SMS", style: .default) { (acao) in
            completion(.sms)
        }
        menu.addAction(sms)
        
        let ligacao = UIAlertAction(title: "Ligar", style: .default) { (acao) in
            completion(.ligacao)
        }
        menu.addAction(ligacao)
        
        let waze = UIAlertAction(title: "Localizar no Waze", style: .default) { (acao) in
            completion(.waze)
        }
        menu.addAction(waze)
        
        let mapa = UIAlertAction(title: "Localizar no mapa", style: .default) { (acao) in
            completion(.mapa)
        }
        menu.addAction(mapa)
        
        let abrirPaginaWeb = UIAlertAction(title: "Abrir pagina web", style: .default) { (acao) in
            completion(.abrirPaginaWeb)
        }
        menu.addAction(abrirPaginaWeb)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}
