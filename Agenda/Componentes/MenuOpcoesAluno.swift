

import UIKit

enum MenuActionSheetAlunos {
    case sms
    case ligacao
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
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
}
