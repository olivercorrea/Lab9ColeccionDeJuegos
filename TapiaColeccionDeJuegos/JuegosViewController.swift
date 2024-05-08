import UIKit
import CoreData

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    @IBOutlet weak var eliminarBoton: UIButton!
    

    var imagePicker = UIImagePickerController()
    
    var juego: Juego? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if let juego = juego {
            imageView.image = UIImage(data: juego.imagen!)
            tituloTextField.text = juego.titulo
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        } else {
            eliminarBoton.isHidden = true
        }
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        // Aquí puedes agregar código para abrir la cámara si lo deseas
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil {
            // Si el juego ya existe, actualizamos sus datos
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            // Si es un nuevo juego, lo creamos y lo agregamos al contexto
            let juego = Juego(context: context)
            juego.titulo = tituloTextField.text
            juego.imagen = imageView.image?.jpegData(compressionQuality: 0.50)
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = ( UIApplication.shared.delegate as!
                        AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagenSeleccionada = info[.originalImage] as? UIImage {
            imageView.image = imagenSeleccionada
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

