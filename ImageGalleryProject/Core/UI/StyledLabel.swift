import UIKit

class StyledLabel: UILabel {
  init(
    text: String,
    style: LabelStyle?,
    layout: String? = nil
  ) {
    super.init(frame: .zero)
    self.text = text
    self.numberOfLines = 0//numLineFromString(layout)
    self.textColor = hexToColor(style?.color)
    self.textAlignment = alignmentFromString(style?.textAlign)
    self.font = generateFont(from: style)

    if style?.underline == true {
      let attributes: [NSAttributedString.Key: Any] = [
        .font: self.font as Any,
        .foregroundColor: self.textColor as Any,
        .underlineStyle: NSUnderlineStyle.single.rawValue,
        .paragraphStyle: {
          let p = NSMutableParagraphStyle()
          p.alignment = self.textAlignment
          return p
        }()
      ]
      self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    self.translatesAutoresizingMaskIntoConstraints = false
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
