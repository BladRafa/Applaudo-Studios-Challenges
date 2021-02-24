//
//  ShowView.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit
import SDWebImage
//import AAViewAnimator

@IBDesignable
class ShowView: UIView {
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showDescriptionLabel: UILabel!
    @IBOutlet weak var showAirDateLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    
    private var viewModel: ShowViewVM!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    func loadXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ShowView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func prepareShowView(viewModel: ShowViewVM) {
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        showNameLabel.text = viewModel.name
        showNameLabel.textColor = UIColor.red
        showDescriptionLabel.text = viewModel.description
        showAirDateLabel.text = viewModel.airdate
        showRatingLabel.text = viewModel.rating
        showImageView.sd_imageIndicator = SDWebImageActivityIndicator.white
        showImageView.sd_setImage(with: URL(string: viewModel.showImageUrl), placeholderImage: UIImage(named: Constants.App.logoPlaceholder))
    }
    
    @IBAction func showViewTapped(_ sender: Any) {
        viewModel.showViewPressed()
    }
}

