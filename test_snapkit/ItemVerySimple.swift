import UIKit
import SnapKit

class ItemVerySimple : UICollectionViewCell {
    static let identifier = "ItemVerySimple"

    private weak var nibView:UIView!
    private var parentWidth:CGFloat? = nil

    @IBOutlet private weak var textTitle: UILabel!
    @IBOutlet private weak var textText: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("ItemVerySimple view can only instantiate by code")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView(){
        let nib = UINib(nibName: ItemVerySimple.identifier, bundle: nil)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else { fatalError("Unable to convert nib") }
        self.nibView = nibView
        nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(nibView)
    }
    
    func updateContent(data: (title:String?, text:String?)) {
        textTitle.text = data.title ?? ""
        textText.text = data.text ?? ""
    }
    
    func makeConstraints(index:IndexPath, parentWidth:CGFloat) {
        nibView.snp.removeConstraints()
        textTitle.snp.removeConstraints()
        textText.snp.removeConstraints()

        clipsToBounds = true
        self.parentWidth = parentWidth
        nibView.snp.makeConstraints { make in
            make.width.equalTo(parentWidth)
        }
        textTitle.snp.makeConstraints { make in
            if textTitle.text == "" { make.height.equalTo(0) }
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(textText.snp.top)
            
        }
        textText.snp.makeConstraints { make in
            if textText.text == "" { make.height.equalTo(0) }
            make.top.equalTo(textTitle.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attribute = super.preferredLayoutAttributesFitting(layoutAttributes)
        attribute.size = .init(width: self.parentWidth ?? 0, height: nibView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
        return layoutAttributes
    }

}
