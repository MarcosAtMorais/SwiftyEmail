//
//  SwiftyEmail.swift
//  SwiftyEmail
//
//  Created by Marcos Morais on 08/05/22.
//

import Foundation
import MessageUI

/**
 A Swift way of sending e-mails through your app using Mail and the top-rated E-mail Messagind apps on the App Store. Don't forget to add the LSApplicationQueriesSchemes key to your Info.plist! Have fun.
 */
open class SwiftyEmail: NSObject {
    /// Shared reference for easy-to-use of the service. Use the sendEmail method to send e-mails.
    public static let shared = SwiftyEmail()

    /**
     Use this method to send your e-mail. It houses the **subject** (String), the **body** (String) of the email _aka message_, and the e-mail of the **recipient** (String).
     
      - parameters:
        - subject: The subject for your e-mail.
        - body: This is the message, what is going to be written on the e-mail.
        - recipient: The e-mail of the recipient.
        - completion: A block to execute after the execution, housing a Result with a boolean with the success of presenting the e-mail provider or the error associated to the action.

     */
    public func sendEmail(subject: String, body: String, recipient: String, completion: @escaping (Result<Bool, Error>) -> Void){
        if MFMailComposeViewController.canSendMail() {
            let picker = MFMailComposeViewController()
            picker.setSubject(subject)
            picker.setMessageBody(body, isHTML: true)
            picker.setToRecipients([recipient])
            picker.mailComposeDelegate = self
            
            guard #available(iOS 11.0, *), let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { completion(.failure(EmailError.unableToPresentViewController))
                return
            }
            guard let window = scene.windows.first else {
                completion(.failure(EmailError.unableToPresentViewController))
                return
            }
            
            window.rootViewController?.present(picker, animated: true)
        } else if let emailUrl = createEmailUrl(recipient: recipient, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
        completion(.success(MFMailComposeViewController.canSendMail()))
    }
    
    /**
     This creates the e-mail URL based on the selected provider. It checks for the top 5 most used e-mail apps. This method will attempt to look for several e-mail apps, so it might produce some logs until it finds the user's favorite e-mail app.
     
      - parameters:
        - recipient: The subject for your e-mail.
        - body: This is the message, what is going to be written on the e-mail.
        - subject: The e-mail of the recipient.
      - returns: An optional URL used to open the e-mail provider app.

     */
    private func createEmailUrl(recipient: String, subject: String, body: String) -> URL? {
        guard let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }

        let gmailUrl = URL(string: "googlegmail://co?to=\(recipient)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(recipient)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(recipient)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(recipient)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(recipient)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }

}

// MARK: - Protocol Conformance for MessageUI
extension SwiftyEmail: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
