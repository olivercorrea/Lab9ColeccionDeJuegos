import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var juegos : [Juego] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            juegos = try context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        } catch {
            print("Error al recuperar los juegos: \(error.localizedDescription)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        if let imageData = juego.imagen {
            cell.imageView?.image = UIImage(data: imageData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue", sender: juego)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! JuegosViewController
        siguienteVC.juego = sender as? Juego
    }
}

