

import UIKit
import MessageUI

class Mensagem: NSObject, MFMessageComposeViewControllerDelegate {
    
    var delegate: MFMessageComposeViewControllerDelegate?
    
    func setaDelegate() -> MFMessageComposeViewControllerDelegate?{
        delegate = self
        return delegate
    }
    
    // MARK: Metodos
    func enviaSMS(_ aluno: Aluno, controller: UIViewController) {
        if MFMessageComposeViewController.canSendText() {
            let componenteMensagem = MFMessageComposeViewController()
            guard let numeroAluno = aluno.telefone else { return }
            componenteMensagem.recipients = [numeroAluno]
            guard let delegate = setaDelegate() else {return }
            componenteMensagem.messageComposeDelegate = delegate
            controller.present(componenteMensagem, animated: true, completion: nil)
            
        }
        
    }
    
    // MARK: MessageComposeDelegate
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
