# Hotline sample for Phonegap plugin#

This sample project acts as a guide to integrating [Hotline Phonegap plugin](https://github.com/freshdesk/hotline-phonegap)

Documentation to integrate the native Hotline SDKs can be found [here](http://hotline.freshdesk.com/support/solutions)

## Usage guide ##

### Setting up the project ###

 1. Clone or download this project.
 
  
 2. Add the required platform to it using the following code
 ```
phonegap platform add android
phonegap platform add ios
```
    
 3. Add the plugin to this project using the following snippet:
```
phonegap plugin add https://github.com/freshdesk/hotline-phonegap
```

 ### Initializing the plugin ###
 
 Call _Hotline.init_ after _ondeviceready_ event listenter to make sure the SDK is initialized before use.
 
```javascript
document.addEventListener("deviceready", function(){
  //Initialize Hotline
  window.Hotline.init({
    appId       : "<Your App Id>",
    appKey      : "<Your App Key>"
  });
});
 ```
 
 Don't forget to replace App Id and App Key with the actual values.
 
 Once initialized you can call Hotline APIs using the window.Hotline object.
 
 More information can be found [here](https://github.com/freshdesk/hotline-phonegap) .
 



