<h1>Project: Creating a IOS wrapper app for Mined Minds.</h1>
<b>Team: Sheri Dyson, John Verbosky, Michael Ciletti, Teela Subba</b>

This project includes complete wrapper of IOS app with Emali/Password, Facebook and Google auto login functionality. Following points are the ways to setup the App.

<li>Download xcode from App store on mac(prefered latest version available).</li>
<li>Create a new xcode project.</li>
<li>Select single view application > Next</li>
        1. Product name: "Name of Project" <br> 
        2. Team: Is your development team(You might need to create an apple ID) <br>
        3. Language: Swift <br>
        4. Devices: Universal > Next
<li>Place where you want to save > Create</li>
<li>Most of the layout will happen in 'Main Storyboard'(Found in left side of the project)</li>

<h2>Whant to create a side scrollview with navigations?</h2>
Go to Top of Toolbar:
Editor > Embed in > Navigation Controller
Drag UIView to View Controller 
To see deatils about layout open AutoTutorial.xcworkspace folder.

<h2>Requrements for the Google Login.</h2>
 -> Need google account.

 -> Need firebase account.

 -> For more details https://firebase.google.com/docs/auth/android/google-signin

<h2>Requirements for Facebook login.</h2>
-> Need facebook account.

-> Need facebook developer account.

-> Downloads SDK from facebook developer page.

-> For more details https://developers.facebook.com/docs/facebook-login/ios