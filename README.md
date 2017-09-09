<h1>Project: Creating a IOS wrapper app for Mined Minds.</h1><hr>
<b>Team: Sheri Dyson, John Verbosky, Michael Ciletti, Teela Subba</b>

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
=======
 -> Need google account.

 -> Need firebase account.

 -> For more details https://firebase.google.com/docs/auth/android/google-signin

Requirements for Facebook login.
=======
-> Need facebook account.

-> Need facebook developer account.

-> Downloads SDK from facebook developer page.

-> For more details https://developers.facebook.com/docs/facebook-login/ios