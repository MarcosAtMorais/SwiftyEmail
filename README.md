<p align="center">
    <img src="https://www.marcostmorais.com/swiftyemail.png">
</p>

![Swift Version](https://img.shields.io/badge/Swift-5.5-F16D39.svg?style=flat) ![Dependency frameworks](https://img.shields.io/badge/Supports-_Swift_Package_Manager-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@marcostmorais-blue.svg?style=flat)](https://twitter.com/marcostmorais)

**SwiftyEmail** is a mini library for iOS, iPadOS and Mac Catalyst using **MessageUI**. With SwiftyEmail, you'll be able to send e-mails from your app calling your user's **favorite e-mail app** (including third party ones!).

## ✨ Features

- **Send E-mails**: Easily send e-mails from your app by calling the correct e-mail app.
- **Third-Party Apps**: Send e-mails with Gmail, Yahoo Mail, Spark or Outlook. We've got you covered with Mail, also!
- **Simple**: Just call a single method and you're done. 
- **Built Swifty** and with **lightweight** in mind.
- **100% Swift**.
- **Documented**.

## 🚀 Get Started

### Using SwiftyEmail in Production Code
Just **import SwiftyEmail**:

```swift
import SwiftyEmail
```

Add the **LSApplicationQueriesSchemes** key to your **Info.plist**. It's an array with four strings.
```swift
<key>LSApplicationQueriesSchemes</key>
<array>
	<string>googlegmail</string>
	<string>ms-outlook</string>
	<string>readdle-spark</string>
	<string>ymail</string>
</array>
```

It should look like this:

<img src="https://www.marcostmorais.com/swifty-email-plist.png">

Okay! 🚀 Now, you can use it as you please. Use it like this:

```swift
SwiftyEmail.shared.sendEmail(subject: "Your order has been processed!",
                             body: "This is just an example for an e-mail body.",
                             recipient: "johndoe@gmail.com") { result in
    switch result {
    case .success(let emailWasSent):
        print("The viewController was presented and the email \(emailWasSent)")
    case .failure(let error):
        print(error.localizedDescription)
    }
}
```

Then, the user's e-mail app is going to be called if the **result** is a success, with all the data provided.

Always remember that the e-mail has a **subject**, a **body** and a **recipient**, as well as the **result** for presenting the e-mail app.

## 🔨 Swift Package Manager

You can also add this library using Swift Package Manager.

1. Go to **File > Add Packages**.
2. The Add Package dialog will appear, by default with Apple packages.
3. In the upper right hand corner, paste https://github.com/MarcosAtMorais/SwiftyEmail into the **search bar**.
4. Hit **Return** to kick off the search.
5. Click **Add Package**.
6. You're all set! Just **import SwiftyEmail** whenever and wherever you want to use it.

## 🌟 Requirements

**iOS** 13+

**iPadOS** 13+

**Mac Catalyst** 13+

