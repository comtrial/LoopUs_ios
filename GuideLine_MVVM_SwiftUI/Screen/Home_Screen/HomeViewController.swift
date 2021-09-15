import SwiftUI
import Combine

class HomeViewController: UIHostingController<HomeContentView> {
    
    var selectedUserToken: Cancellable?
    
    let  homeViewModel: HomeViewModel
    
    override init(rootView: HomeContentView) {
        self.homeViewModel = HomeViewModel()
        super.init(rootView: rootView)

        configureCommunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        homeViewModel.fetchRandomUsers()
        homeViewModel.fetchHomeFeeds()
        //getDatas()
    }
    
    func configureCommunication() {
        selectedUserToken = rootView.selectedFeedPublisher.sink{ [weak self] feed in
            self?.presentAlert(with:"\(feed.username)을 클릭하셨네여")
        }
    }
}
