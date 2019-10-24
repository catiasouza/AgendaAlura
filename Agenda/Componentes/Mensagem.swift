

import UIKit
import MessageUI

class Mensagem: NSObject, MFMessageComposeViewControllerDelegate {
    
    // MARK: Metodos
    func configuraSMS(_ aluno: Aluno) -> MFMessageComposeViewController? {
        if MFMessageComposeViewController.canSendText() {  // verificando se esta usando iphone
            let componenteMensagem = MFMessageComposeViewController()
            guard let numeroAluno = aluno.telefone else { return componenteMensagem }
            componenteMensagem.recipients = [numeroAluno]
            componenteMensagem.messageComposeDelegate = self
            return componenteMensagem
            
        }
        return nil
    }
    
    
    // MARK: MessageComposeDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
