//
//  ViewController.m
//  socketrocketpinnerobjc
//
//  Created by Rani Aljondi on 10/25/17.
//  Copyright © 2017 Rani Aljondi. All rights reserved.
//

#import "ViewController.h"
#import "SocketRocket/SRWebSocket.h"

@interface ViewController () <SRWebSocketDelegate> {
    
    SRWebSocket *_socket;
    
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [[NSURL alloc] initWithString:@"wss://echo.websocket.org"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    
    /*Critical section:
     
     https://github.com/facebook/SocketRocket/issues/473:
     Before feature was deprecated, SocketRocket changed multiple certificate behavior from fallback certificates (where certificate needs to match any one of the certificates in the truststore)
     to all certificates: where all certificates must be valid.
     This would recommend against pinning more than a single certificate at a time.
     
     
     Functionality: github.com.der does not match certificate of URL, so connection fails. When certificate isn't attached, connection succeeds.
     
     In order to test: add
     
     Certificates must be in der format.
     
     
     
     */
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"github.com" ofType:@"der"];
    NSData *certData = [[NSData alloc] initWithContentsOfFile:cerPath];
    CFDataRef certDataRef = (__bridge CFDataRef)certData;
    SecCertificateRef certRef = SecCertificateCreateWithData(NULL, certDataRef);
    id certificate = (__bridge id)certRef;
    if (!certificate) {
        NSLog(@"certificate found");
        [request setSR_SSLPinnedCertificates:@[certificate]];
    }
    _socket = [[SRWebSocket alloc] initWithURLRequest:request];
    _socket.delegate = self;
    NSString *str = @"test string";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:str];
    NSString *thatStr = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    [_socket open];
}

- (IBAction)buttonClick:(id)sender {
    NSString *str = @"test string";
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:str];
    [_socket sendPing:data];
    NSLog(@"no wow");
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }

- (instancetype)initWithMessage:(NSString *)message incoming:(BOOL)incoming
{
    self = [super init];
    if (!self) return self;
    
    return self;
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    // your existing code
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSLog(@"Opened socket!");
    [center postNotificationName:@"wss://echo.websocket.org" object:webSocket];
}


- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string {
    NSLog(@"string");
    }

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data {
    NSLog(@"data.description");
    
    }

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"Connection failed");
    }

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean {
    
    }

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [_socket close];
    _socket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
    NSLog(@"WebSocket received pong");
    }


@end


