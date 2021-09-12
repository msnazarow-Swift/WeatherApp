import UIKit

class DesignableUITextField: UITextField {
    var leftPadding: CGFloat = 0
    var rightPadding: CGFloat = 0

    var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    var color = UIColor.lightGray {
        didSet {
            updateView()
        }
    }

    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: color])
    }

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let textRect = super.leftViewRect(forBounds: bounds)
        return textRect.offsetBy(dx: leftPadding, dy: 0).insetBy(dx: -rightPadding, dy: 0)
    }
}
