

import UIKit


class MenuOpcoesAluno: NSObject {
  
    func configuraMenuDeOpcoesAluno(navigation: UINavigationController, alunoSelecionado:Aluno) -> UIAlertController{
        let menu = UIAlertController(title: "Atencao", message: "Escolha uma das opcoes abaixo", preferredStyle: .actionSheet)
        
        guard let viewController = navigation.viewControllers.last else {return menu}
        
        let sms = UIAlertAction(title: "Enviar SMS", style: .default) { (acao) in
            Mensagem().enviaSMS(alunoSelecionado, controller: viewController)
        }
        menu.addAction(sms)
        
        let ligacao = UIAlertAction(title: "Ligar", style: .default) { (acao) in
            LigacaoTelefonica().fazLigacao(alunoSelecionado)
        }
        menu.addAction(ligacao)
        
        let waze = UIAlertAction(title: "Localizar no Waze", style: .default) { (acao) in
            Localizacao().localizaAlunoNoWaze(alunoSelecionado)
        }
        menu.addAction(waze)
        
        let mapa = UIAlertAction(title: "Localizar no mapa", style: .default) { (acao) in
            let mapa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapa") as! MapaViewController
            mapa.aluno = alunoSelecionado
            navigation.pushViewController(mapa, animated: true)
           
            
        }
        menu.addAction(mapa)
        
        let abrirPaginaWeb = UIAlertAction(title: "Abrir pagina web", style: .default) { (acao) in
            Safari().abrePaginaWeb(alunoSelecionado, controller: viewController)
        }
        menu.addAction(abrirPaginaWeb)
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        menu.addAction(cancelar)
        
        return menu
    }
}
