
import UIKit

class LigacaoTelefonica: NSObject {
    func fazLigacao(_ alunoSelecionado: Aluno){
        
        guard let numeroDoAluno = alunoSelecionado.telefone else { return }
        if let url = URL(string: "tel://\(numeroDoAluno)"), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
    }
}
