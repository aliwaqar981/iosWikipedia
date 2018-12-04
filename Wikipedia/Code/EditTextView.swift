import UIKit

@objc(WMFEditTextViewDataSource)
protocol EditTextViewDataSource: class {
    var shouldShowCustomInputViewController: Bool { get set }
}

@objc(WMFEditTextView)
class EditTextView: UITextView {
    @objc weak var dataSource: EditTextViewDataSource?
    @objc weak var inputViewControllerDelegate: TextFormattingTableViewControllerDelegate?

    private lazy var editMenuItems: [UIMenuItem] = {
        let addCitation = UIMenuItem(title: "+", action: #selector(addCitation(_:)))
        let addLink = UIMenuItem(title: "🔗", action: #selector(addLink(_:)))
        let addCurlyBrackets = UIMenuItem(title: "{}", action: #selector(addCurlyBrackets(_:)))
        let makeBold = UIMenuItem(title: "𝗕", action: #selector(makeBold(_:)))
        let makeItalic = UIMenuItem(title: "𝐼", action: #selector(makeItalic(_:)))
        return [addCitation, addLink, addCurlyBrackets, makeBold, makeItalic]
    }()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setEditMenuItems()
    }

    private func setEditMenuItems() {
        guard let newMenuItems = existingMenuItemsCombinedWithEditMenuItems else {
            return
        }
        UIMenuController.shared.menuItems = newMenuItems
    }

    private lazy var existingMenuItemsCombinedWithEditMenuItems: [UIMenuItem]? = {
        guard let existingMenuItems = UIMenuController.shared.menuItems else {
            return editMenuItems
        }
        let existing = NSMutableOrderedSet(array: existingMenuItems)
        let new = NSOrderedSet(array: editMenuItems)
        existing.union(new)
        guard let newMenuItems = Array(existing) as? [UIMenuItem] else {
            return nil
        }
        return newMenuItems
    }()

    override var inputViewController: UIInputViewController? {
        guard
            let dataSource = dataSource,
            dataSource.shouldShowCustomInputViewController else {
            return nil
        }
        let textFormattingInputViewController = TextFormattingInputViewController.wmf_viewControllerFromStoryboardNamed("TextFormatting")
        textFormattingInputViewController.delegate = inputViewControllerDelegate
        return textFormattingInputViewController
    }

    @objc private func makeBold(_ sender: UIMenuItem) {

    }

    @objc private func makeItalic(_ sender: UIMenuItem) {

    }

    @objc private func addCitation(_ sender: UIMenuItem) {

    }

    @objc private func addLink(_ sender: UIMenuItem) {

    }

    @objc private func addCurlyBrackets(_ sender: UIMenuItem) {

    }
}

extension EditTextView: Themeable {
    func apply(theme: Theme) {
        backgroundColor = theme.colors.paperBackground
        textColor = theme.colors.primaryText
        keyboardAppearance = theme.keyboardAppearance
    }
}
