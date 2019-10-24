

import UIKit

enum MenuActionSheetAlunos {
    case sms
}

class MenuOpcoesAluno: NSObject {
  
    func configuraMenuDeOpcoesAluno(completion:@escaping(_ opcao:MenuActionSheetAlunos) -> Void) -> UIAlertController{
        let menu = UIAlertController(title: "Atencao", message: "Escolha uma das opcoes abaixo", preferredStyle: .actionSheet)
        
        let sms = UIAlertAction(title: "Enviar SMS", style: .default) { (acao) in
            completion(.sms)
        }
        menu.addAction(sms)
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        return menu
    }
}
