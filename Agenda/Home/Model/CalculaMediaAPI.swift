

import UIKit

class CalculaMediaAPI: NSObject {

    func calculaMediaGeralDosAlunos(){
        
        //url end do postmain no POST
        guard let url = URL(string: "https://www.caelum.com.br/mobile")else{return}
        //CORPO DA API
      
        var listaDeAlunos: Array<Dictionary<String, Any>> = []
        var json: Dictionary<String, Any> = [:]
        
        //INFORMACOES QUE ESTA NO POSTMAIN
       let dicionarioDeAlunos = [
            "id": "1",
            "nome":"Catia",
            "endereco": "Rua Cotonificio",
            "telefone": "9999-9999",
            "site": "www.alura.com.br",
            "nota": "8"
        ]
        listaDeAlunos.append(dicionarioDeAlunos as [String: Any])
        json = [
            "list": [
                [ "aluno": listaDeAlunos]
            ]
        ]
       
        do{
            var requisicao = URLRequest(url: url )
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            requisicao.httpBody = data
            requisicao.httpMethod = "POST"
            requisicao.addValue("aplication/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: requisicao) { (data, response, error) in
                if error == nil{
                    do{
                        let dicionario = try JSONSerialization.jsonObject(with: data!, options: [])
                        print(dicionario)
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                }
            }
            task.resume()
        }catch{
            print(error.localizedDescription)
        }
        
    }
}
