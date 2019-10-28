

import UIKit

class Notificacoes: NSObject {
    
    func exibeNotificacoesDeMediaDosAlunos(dicionariodeMedia:Dictionary<String,Any>) -> UIAlertController?{
        if let media = dicionariodeMedia["media"] as? String{
            let alerta = UIAlertController(title: "Atencao", message: "A media dos alunos é: \(media)", preferredStyle: .alert)
            let botao = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alerta.addAction(botao)
            return alerta
        }
       return nil
    }
}
