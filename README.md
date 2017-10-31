# socketrocketpinnerobjc
An implementation of SocketRocket's (deprecated) certificate pinning option.

https://www.owasp.org/index.php/Certificate_and_Public_Key_Pinning

Investigating ways of using SocketRocket and OkHttp APIs to validate a Certificate Chain based on URL of an intermediate Certificate Authority.
Important terms:
Keys: In this document, refers to the chain of public keys enclosed with digital certificate. 
Certificate Authority (CA): entity that issues digital certificates; this falls into three categories: root, intermediary, and end entity.

Trust chain validation: conventional process of validating certificates,Does not check for CA identifiers the same way certificate pinning does.

Pinned Certificate validation: assigns a specific certificate or public key to an intermediate CA. Client receiving certificate has a copy of certificate(s) that given certificate has to include to be considered valid.

Verdict: best method of certifying that Bose.com is Intermediary Certificate Authority is by Pinned Certificate Validation.

In SocketRocket, can only validate using stored certificates (as opposed to public keys or hashes, options other libraries provide). In addition, if multiple certificates are in pinstore, certificate must include all of them in order to be validated.

In addition, Certificate Pinning is deprecated as of most recent commit to library (see below).


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


References recommending against certificate pinning

https://github.com/facebook/SocketRocket/commit/28035e1a98a427853e4038ff1b70479fa8374cfa

https://www.synopsys.com/blogs/software-security/ineffective-certificate-pinning-implementations/

http://www.zdnet.com/article/google-chrome-is-backing-away-from-public-key-pinning-and-heres-why/

