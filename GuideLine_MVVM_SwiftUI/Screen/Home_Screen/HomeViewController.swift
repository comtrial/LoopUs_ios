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
        homeViewModel.fetchRandomUsers()
        //getDatas()
    }
    
    func configureCommunication() {
        selectedUserToken = rootView.selectedUserPublisher.sink{ [weak self] user in
            self?.presentAlert(with:"\(user.description)을 클릭하셨네여")
        }
    }
//    func getDatas() {
//        networkingService.getUsers{ [weak self] users in
//            self?.rootView.sot.users = users
//        }
//    }
}
