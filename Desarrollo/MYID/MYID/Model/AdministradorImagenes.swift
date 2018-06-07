import Foundation

class AdministradorImagenes {
    
    static let instancia = AdministradorImagenes()
    
    func guardarImagen(image: UIImage, nombre: String) -> Bool {
        guard let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image) else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent(nombre + ".png")!)
            return true
        } catch {
            return false
        }
    }
    
    func obtenerImagen(nombre: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(nombre).path)
        }
        return nil
    }
    
}
