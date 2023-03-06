import UIKit
import AuthenticationServices

class SignInWithAppleDelegates: NSObject {
    
    private let signInSucceeded: (Bool) -> Void

    init(onSignedIn: @escaping (Bool) -> Void) {
        self.signInSucceeded = onSignedIn
    }
}

extension SignInWithAppleDelegates: ASAuthorizationControllerDelegate {
    private func registerNewAccount(credential: ASAuthorizationAppleIDCredential) {
        var user = User()
        user.login_id = credential.user
        
        #if LOCAL_API
        if let url = URL(string: registerUserAppleIdAPI + user.login_id + "&loginType=APPLE" + "&registerDate=" + user.register_date) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if data != nil {
                    print("Apple ID Registration successful.")
                }
            }.resume()
        }
        #endif
        
        var firestoreUser = FirestoreUser()
        firestoreUser.loginId = credential.user
        firestoreUser.loginType = "APPLE"
        firestoreUser.profileName = UserDefaults.standard.string(forKey: "UserNickname") ?? "고객"
        firestoreUser.registerDate = getTimeNow()
        let firestoreUserRepository = FirestoreUserRepository()
        firestoreUserRepository.add(firestoreUser)
        
        UserDefaults.standard.set(user.login_id, forKey: "AppleLoginID")
        self.signInSucceeded(true)
    }
    
    private func signInWithExistingAccount(credential: ASAuthorizationAppleIDCredential) {
        var user = User()
        
        #if LOCAL_API
        if let url = URL(string: getRegisteredUserAPI + credential.user) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        user = try JSONDecoder().decode(User.self, from: data)
                        UserDefaults.standard.set(user.id, forKey: "UserID")
                    } catch let error {
                        print("signInWithExistingAccount error = \(error)")
                    }
                } else {

                }
            }.resume()
        }
        #endif
        
        UserDefaults.standard.set(credential.user, forKey: "AppleLoginID")
        self.signInSucceeded(true)
    }
    
    private func signInWithUserAndPassword(credential: ASPasswordCredential) {
        self.signInSucceeded(true)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            case let appleIdCredential as ASAuthorizationAppleIDCredential:
            if let _ = appleIdCredential.email {
                registerNewAccount(credential: appleIdCredential)
            } else {
                signInWithExistingAccount(credential: appleIdCredential)
            }
            break
        
            case let passwordCredential as ASPasswordCredential:
            signInWithUserAndPassword(credential: passwordCredential)
            break
        
            default:
            print("authorizationController default")
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
}
