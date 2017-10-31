# socketrocketpinnerobjc
An implementation of SocketRocket's (deprecated) certificate pinning option.

Setup: 
1. Terminal to project root directory
2. command: "pod install"
3. open xcode, then select option to open project using File Explorer, navigate to project root directory
4. IMPORTANT: click on socketrocketpinnerobj.xcworkspace

Current functionality:
1. Xcode: Highlight root socketrocketpinnerobjc file in Project Explorer (the top level folder with the blue icon)
2. Xcode: Files->"Add Files to socketrocketpinnerobjc"-> select certificate file (must be in der format) 
3. Doing this should place an icon corresponding to the certificate under the main folder in Project Explorer.
4. IN ViewController.m: change url string parameter to desired web socket address <Note: HTTP addresses are not valid since SR does not work at that layer.
5. ViewController.m: change cerPath to contain the name and file extension of certificate you wish to pin to. Note that the certificate format must always be der.
6. In order to turn off certificate pinning, go to if statement if(certificate) and replace certificate with nil.
