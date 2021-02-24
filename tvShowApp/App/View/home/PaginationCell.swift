//
//  PaginationCell.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit

class PaginationCell: ReusableTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    @IBOutlet weak var paginationIndicator: UIPageControl!
    
    private var viewModel: PaginationCellVM!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(viewModel: PaginationCellVM) {
        pagingScrollView.delegate = self
        self.viewModel = viewModel
        setUpUI()
    }
    
    private func setUpUI() {
        configurePaginationIndicator()
        // Provide a delay of few secs to let the frames of views to be laid properly
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.configureScrollView()
        }
        titleLabel.text = viewModel.title
    }
    
    private func configureScrollView() {
        for i in 0..<viewModel.numberOfPages{
            let showView = ShowView()
            showView.frame = CGRect(x: pagingScrollView.frame.size.width*CGFloat(i), y: 0, width: pagingScrollView.frame.size.width, height: pagingScrollView.frame.size.height)
            showView.prepareShowView(viewModel: viewModel.viewModelForShowView(position: i))
            pagingScrollView.addSubview(showView)
        }
        pagingScrollView.contentSize = CGSize(width: pagingScrollView.frame.size.width * CGFloat(viewModel.numberOfPages), height: pagingScrollView.frame.size.height)
    }
    
    private func configurePaginationIndicator() {
        paginationIndicator.numberOfPages = viewModel.numberOfPages
        paginationIndicator.currentPage = 0
        paginationIndicator.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    
    @objc private func changePage(sender: AnyObject) -> () {
        let x = CGFloat(paginationIndicator.currentPage) * pagingScrollView.frame.size.width
        pagingScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
}

// MARK: UIScrollViewDelegate
extension PaginationCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        paginationIndicator.currentPage = Int(pageNumber)
    }
}

