import UIKit

class PostCellView: UITableViewCell {
    typealias DisplayedPost = PostsModel.Recent.ViewModel.DisplayedPost
        
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setData(displayedPost: DisplayedPost){
        titleLabel.text = displayedPost.storyTitle
        authorLabel.text = displayedPost.author ?? ""
        dateLabel.text = "- " + DateFormatter().timeSince(from: displayedPost.createdAt as NSDate, numericDates: true)
    }
}
