//
//  DetailViewController.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 23/2/21.
//

import UIKit
import SDWebImage
//import MaterialComponents.MaterialDialogs

class DetailViewController: UIViewController {
    
    @IBOutlet weak var cvCast: UICollectionView!
    @IBOutlet weak var lblShowName: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var imgShowPoster: UIImageView!
    @IBOutlet weak var lblRated: UILabel!
    @IBOutlet weak var lblCreatedBy: UILabel!
    @IBOutlet weak var imgSeasonPoster: UIImageView!
    @IBOutlet weak var lblSeasonName: UILabel!
    @IBOutlet weak var lblSeasonEpisodies: UILabel!
    @IBOutlet weak var lblSeasonOverview: UILabel!
    
    var show:Show!
    private var viewModel: DetailViewModel!

    // MARK: LifeCycle App
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailViewModel(show: show!)
        prepareCollectionView()
        customRender()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func prepareCollectionView() {
        cvCast.dataSource = self
        cvCast.delegate = self
        ImageAndLabelCollectionCell.registerWithCollectionView(cvCast)
    }
    
    // MARK: Customize View
    private func customRender() {
        // Customize Views for Detail View Controller
        imgShowPoster.sd_setImage(with: URL(string: "\(Constants.WS.baseURLImages.rawValue)\(show?.backdropPath ?? "")"), placeholderImage: UIImage(named: Constants.App.logoPlaceholder))
        imgShowPoster.sd_imageIndicator = SDWebImageActivityIndicator.white
        lblShowName.text = show?.name
        let avg = Int((show?.voteAverage ?? 1) * 10)
        lblRated.text = "\(avg) %"
        lblOverview.text = show?.overview
        lblCreatedBy.text = viewModel.setAuthors()
        setSeason()
    }
    
    private func setSeason() {
        lblSeasonName.text = viewModel.season()?.name
        lblSeasonOverview.text = "\(viewModel.season()?.overview ?? "")\n\nStatus: \(show.detail?.status ?? "")"
        imgSeasonPoster.sd_setImage(with: URL(string: "\(Constants.WS.baseURLImages.rawValue)\(viewModel.season()?.poster_path ?? "")"), placeholderImage: UIImage(named: Constants.App.logoPlaceholder))
        imgSeasonPoster.sd_imageIndicator = SDWebImageActivityIndicator.white
        lblSeasonEpisodies.text = "\(viewModel.season()?.air_date.dateFormat(formatIn: Constants.App.dateFormatIn, formatOut: Constants.App.dateFormatOut) ?? "")\n\(viewModel.season()?.episode_count ?? 0) Episodies"
    }
}

// MARK: UICollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageAndLabelCollectionCell.reuseIdentifier, for: indexPath) as! ImageAndLabelCollectionCell
        cell.prepareCell(viewModel: viewModel.cellViewModel(indexPath: indexPath))
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4, height: collectionView.frame.size.height - 5)
    }
}
