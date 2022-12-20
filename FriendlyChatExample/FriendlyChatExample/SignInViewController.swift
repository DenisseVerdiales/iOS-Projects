//
//  ViewController.swift
//  FriendlyChatExample
//
//  Created by Marquis Kurt on 29/7/22.
//

import UIKit
import SwiftUI
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import GoogleSignInSwift
import SnapKit



class SignInViewController: UIViewController {

    lazy var signInHostingView: UIHostingController = {
        return UIHostingController(rootView: GoogleSignInButton(action: self.signIn))
    }()

    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        

        GIDSignIn.sharedInstance.restorePreviousSignIn()
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            // TODO: Figure the new way for doing this...
        })

        addChild(signInHostingView)
        view.addSubview(signInHostingView.view)
        signInHostingView.didMove(toParent: self)

        signInHostingView.view.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(44)
            make.centerWithinMargins.equalTo(self.view.snp_centerWithinMargins)
        }

        // Do any additional setup after loading the view.
    }

    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }

    func signIn() {
        guard let config = AppDelegate.gidConfig else { return }
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            guard error == nil else { return }
            guard let authentication = user?.authentication, let idToken = authentication.idToken else {
                return
            }

            let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credentials) { user, error in
                if let error = error {
                    print("FUCK: \(error)")
                    return
                }

                print(user)
            }
        }
    }


}

