This project includes complete wrapper of IOS app with Emali/Password, Facebook and Google auto login functionality. Following points are the ways to setup the App.
1. Download xcode from App store on mac(prefered latest version available).
2. Create a new xcode project.
3. Select single view application > Next
        1. Product name: "Name of Project"
        2. Team: Is your development team(You might need to create an apple ID) 
        3. Language: Swift
        4. Devices: Universal > Next
4. Place where you want to save > Create
5. Most of the layout will happen in 'Main Storyboard'(Found in left side of the project)

Whant to create a side scrollview with navigations?
Go to Top of Toolbar:
Editor > Embed in > Navigation Controller
Drag UIView to View Controller 
To see deatils about layout open AutoTutorial.xcworkspace folder.
Requrements for the Google Login.
Open your project configuration: double-click the project name in the left tree view. Select your app from the TARGETS section, then select the Info tab, and expand the URL Types section.
Click the + button, and add a URL scheme for your reversed client ID. To find this value, open the GoogleService-Info.plist configuration file, and look for the REVERSED_CLIENT_ID key. Copy the value of that key, and paste it into the URL Schemes box on the configuration page. Leave the other fields blank.

Integrating Google Sign-In into your iOS app

Google Sign-In manages the OAuth 2.0 flow and token lifecycle, simplifying your integration with Google APIs.

Before you begin

Download the dependencies and configure your Xcode project.

Enable sign-in

To enable sign in, you must configure the GGLContext shared instance (or, if you manually installed the SDK, the GIDSignIn shared instance). You can do this in many places in your app. Often the easiest place to configure this instance is in your app delegate's application:didFinishLaunchingWithOptions: method.

In your app's project-Bridging-Header.h file, import the Google Sign-In SDK headers:
#import <Google/SignIn.h>
SignInExampleSwift-Bridging-Header.h
Note: If you manually installed the SDK, you should instead import GoogleSignIn/GoogleSignIn.h.
If your project does not have a project-Bridging-Header.h file, you can create one by adding an Objective-C file to your app. The easiest way to do this is to drag and drop a .m file into your project—which creates the bridging header and configures your project to use it—then delete the .m file. See Swift and Objective-C in the Same Project for more information.
In your app delegate (AppDelegate.swift), declare that this class implements the GIDSignInDelegate protocol.
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
AppDelegate.swift
In your app delegate's application:didFinishLaunchingWithOptions: method, configure the GGLContext shared instance and set the sign-in delegate.
AppDelegate.swift
Note: If you manually installed the SDK, you should instead configure the GIDSignIn object directly, using the client ID found in the GoogleService-Info.plist file: 
GIDSignIn.sharedInstance().clientID = kClientID
Implement the application:openURL:options: method of your app delegate. The method should call the handleURL method of the GIDSignIn instance, which will properly handle the URL that your application receives at the end of the authentication process. 
For your app to run on iOS 8 and older, also implement the deprecated application:openURL:sourceApplication:annotation: method.


In the app delegate, implement the GIDSignInDelegate protocol to handle the sign-in process by defining the following methods:
func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
  withError error: NSError!) {
    if (error == nil) {
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // ...
    } else {

AppDelegate.swift
Note: The Sign-In SDK automatically acquires access tokens, but the access tokens will be refreshed only when you call signIn or signInSilently. To explicitly refresh the access token, call the refreshTokensWithHandler: method. If you need the access token and want the SDK to automatically handle refreshing it, you can use the getTokensWithHandler: method.
Important: If you need to pass the currently signed-in user to a backend server, send the user's ID token to your backend server and validate the token on the server.
Add the sign-in button

Next, you will add the Google Sign-In button so that the user can initiate the sign-in process. Make the following changes to the view controller that manages your app's sign-in screen:

In the view controller, declare that this class implements the GIDSignInUIDelegate protocol.
class ViewController: UIViewController, GIDSignInUIDelegate {
ViewController.swift
In the view controller, override the viewDidLoad method to set the UI delegate of the GIDSignIn object, and (optionally) to sign in silently when possible.
override func viewDidLoad() {
  super.viewDidLoad()

  GIDSignIn.sharedInstance().uiDelegate = self

  // Uncomment to automatically sign in the user.
  //GIDSignIn.sharedInstance().signInSilently()
}
ViewController.swift
Note: When users silently sign in, the Sign-In SDK automatically acquires access tokens and automatically refreshes them when necessary. If you need the access token and want the SDK to automatically handle refreshing it, you can use the getAccessTokenWithHandler: method. To explicitly refresh the access token, call the refreshAccessTokenWithHandler: method.
In these examples, the view controller is a subclass of UIViewController. If, in your project, the class that implements GIDSignInUIDelegate is not a subclass of UIViewController, implement the signInWillDispatch:error:, signIn:presentViewController:, and signIn:dismissViewController: methods of the GIDSignInUIDelegate protocol. For example:
// Implement these methods only if the GIDSignInUIDelegate is not a subclass of
// UIViewController.

// Stop the UIActivityIndicatorView animation that was started when the user
// pressed the Sign In button
func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
  myActivityIndicator.stopAnimating()
}

// Present a view that prompts the user to sign in with Google
func signIn(signIn: GIDSignIn!,
    presentViewController viewController: UIViewController!) {
  self.presentViewController(viewController, animated: true, completion: nil)
}

// Dismiss the "Sign in with Google" view
func signIn(signIn: GIDSignIn!,
    dismissViewController viewController: UIViewController!) {
  self.dismissViewControllerAnimated(true, completion: nil)
}
Add a GIDSignInButton to your storyboard, XIB file, or instantiate it programmatically. To add the button to your storyboard or XIB file, add a View and set its custom class to GIDSignInButton.
When you add a GIDSignInButton view to your storyboard, the sign-in button doesn't render in the interface builder. Run the app to see the sign-in button.
If you want to customize the button, do the following:
In your view controller, declare the sign-in button as a property.
@IBOutlet weak var signInButton: GIDSignInButton!
Connect the button to the signInButton property you just declared.
Customize the button by setting the properties of the GIDSignInButton object.
Next, you can implement and handle the sign-out button.

Sign out the user

You can use the signOut method of the GIDSignIn object to sign out your user on the current device, for example:

@IBAction func didTapSignOut(sender: AnyObject) {
  GIDSignIn.sharedInstance().signOut()
}
