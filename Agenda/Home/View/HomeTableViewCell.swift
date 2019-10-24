

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageAluno: UIImageView!
    @IBOutlet weak var labelNomeDoAluno: UILabel!
    
    func configuraCelula(_ aluno: Aluno){
           labelNomeDoAluno.text = aluno.nome
        
        imageAluno.layer.cornerRadius = imageAluno.frame.width / 2
        imageAluno.layer.masksToBounds = true
             if let imagenDoAluno = aluno.foto as? UIImage{
                 imageAluno.image = imagenDoAluno
             }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
