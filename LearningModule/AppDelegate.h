//
//  AppDelegate.h
//  LearningModule
//
//  Created by Kevin Donahoo on 2/6/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
using namespace std;
#endif

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
#ifdef __cplusplus
- (void)sendFramesAndWriteToFile:(cv::Mat*)matBuffer:(int)matBufferLength:(string)module:(string)page;
- (void)changeModuleAndHandleTimers:(NSMutableArray*)array1:(NSMutableArray*)arrray2:(NSString*)moduleNumber;
#endif
@end

