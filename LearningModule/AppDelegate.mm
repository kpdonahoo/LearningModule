//
//  AppDelegate.m
//  LearningModule
//
//  Created by Kevin Donahoo on 2/6/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "AppDelegate.h"

using namespace cv;

@interface AppDelegate ()

@end

@implementation AppDelegate

dispatch_queue_t backgroundQueue;
int numberOfFrames = 0;
int fileNumber = 0;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    backgroundQueue = dispatch_queue_create("com.mycompany.myqueue", DISPATCH_QUEUE_SERIAL);
    
    UITextField *lagFreeField = [[UITextField alloc] init];
    [self.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];
    
    return YES;
}

-(UIImage *)imageWithCVMat:(const Mat&)cvMat {
    
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
    
    CGColorSpaceRef colorSpace;
    
    if(cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGImageRef imageRef = CGImageCreate(cvMat.cols,
                                        cvMat.rows,
                                        8,
                                        8 * cvMat.elemSize(),
                                        cvMat.step[0],
                                        colorSpace,
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,
                                        provider,
                                        NULL,
                                        false,
                                        kCGRenderingIntentDefault);
    
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return image;
    
}

- (void)sendFramesAndWriteToFile:(Mat*)matBuffer:(int)matBufferLength:(string)module:(string)page{
    NSLog(@"Started sending frames");
    fileNumber = fileNumber + 1;
    NSString *text = [NSString stringWithFormat:@""];
    NSString *fileName = [NSString stringWithFormat:@"%s-%d", module.c_str(), fileNumber];
    for(int i = 0; i < matBufferLength; i++) {
        UIImage *uImage = [self imageWithCVMat:matBuffer[i]];
        NSData *dataObj = UIImageJPEGRepresentation(uImage, 1.0);
        //int bytes = [dataObj length];
        NSString *byteArray = [dataObj base64Encoding];
        NSString *thisTemp = [NSString stringWithFormat:@"image%d", numberOfFrames++];
        text = [NSString stringWithFormat:@"%@%@%@", text, thisTemp, byteArray];
        //NSLog(text);
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    dispatch_async(backgroundQueue, ^{
        [text writeToFile:appFile atomically:YES];
    });

    NSLog(@"%@", documentsDirectory);
    
}

- (void)changeModuleAndHandleTimers:(NSMutableArray*)array1:(NSMutableArray*)array2:(NSString*)moduleNumber {
    NSString *textToSend = [NSString stringWithFormat:@""];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:moduleNumber];
    for(int i = 0; i < [array1 count]; i++) {
        textToSend = [NSString stringWithFormat:@"%@%@", textToSend, [array1 objectAtIndex:i]];
    }
    
    if(array2 != nullptr) {
        for(int j = 0; j < [array2 count]; j++) {
            textToSend = [NSString stringWithFormat:@"%@%@", textToSend, [array2 objectAtIndex:j]];
        }
    }
    
    [textToSend writeToFile:appFile atomically:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
