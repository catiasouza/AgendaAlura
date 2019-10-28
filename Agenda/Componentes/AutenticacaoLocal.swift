

import UIKit
import LocalAuthentication

class AutenticacaoLocal: NSObject {
    
    func autorizaUsuario(completion:@escaping(_ autenticacado:Bool)-> Void){
        
        var error: NSError?
        let contexto = LAContext()
        if contexto.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            contexto.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "é necessario autenticacao para apagar um aluno", reply: { (resposta, erro) in
                completion(resposta)
            })
            
        }
    }
}
