import UIKit
import LoremIpsum

var randomContent: [Int: (title:String?, text:String?)] = {
    var data:[Int: (title:String?, text:String?)] = .init()
    (0...100).forEach { index in
        let text = Bool.random() ? "\(index) text: \(LoremIpsum.words(withNumber: Int.random(in: 10...40))!)" : nil
        let title = Bool.random() || text == nil ? "\(index) title: \(LoremIpsum.words(withNumber: Int.random(in: 1...5))!)" : nil
        data[index] = (title, text)
    }
    return data
}()

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(ItemVerySimple.self, forCellWithReuseIdentifier: ItemVerySimple.identifier)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 10
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return randomContent.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemVerySimple.identifier, for: indexPath)
        guard let cell = cell as? ItemVerySimple else { return cell }
        let data = randomContent[indexPath.row] ?? (title: "index \(indexPath.row) : title", text: "text")
        cell.updateContent(data: data)
        cell.makeConstraints(index: indexPath, parentWidth: collectionView.frame.width)
        return cell
    }
    
}


