//
//  Module2.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module2.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif
#import "AppDelegate.h"

using namespace cv;

@interface Module2 () <CvVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beginModuleButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *continueToQuizButton;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) UIView *cameraOutput;
@property (strong, nonatomic) CvVideoCamera* videoCamera;

@end

@implementation Module2
@synthesize cameraOutput;
@synthesize image;
@synthesize beginModuleButton;
@synthesize continueToQuizButton;
@synthesize pageLabel;
NSArray *images_m2;
int imageIndex_m2;
int pageViews_m2[11];
NSMutableArray *timePerPage_m2;
NSTimeInterval total_m2;
NSTimer *transitionTimer_m2;
NSDate* startDate_m2;
Mat imageFrames_m2[48];
int frameCount_m2 = 0;
int frameNumber_m2 = 0;
NSString *frame_m2;
AppDelegate *appDelegate_m2;


- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_m2];
    total_m2 +=elapsedTime;
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_m2 invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_m2 = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_m2 = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoCamera start];
    appDelegate_m2 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSNumber *dummy = @0;
    timePerPage_m2 = [[NSMutableArray alloc] init];
    
    for (int counter = 0; counter < 11; counter++) {
        [timePerPage_m2 addObject:dummy];
    }
    
    for (int counter = 0; counter < 11; counter++) {
        pageViews_m2[counter] = 0;
    }
    
    
    [image setUserInteractionEnabled:YES];
    
    UIFont *font = [UIFont fontWithName:@"PTSans-Regular" size:18];
    pageLabel.font = font;
    imageIndex_m2 = 0;
    
    images_m2 = @[@"Module2-1 copy.png",@"Module2-2 copy.png",@"Module2-3 copy.png",@"Module2-4 copy.png",@"Module2-5 copy.png",@"Module2-6 copy.png",@"Module2-7 copy.png"];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.videoCamera stop];
}

#ifdef __cplusplus
-(CvVideoCamera *)videoCamera{
    if(!_videoCamera) {
        _videoCamera = [[CvVideoCamera alloc] initWithParentView:self.cameraOutput];
        _videoCamera.delegate = self;
        _videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
        _videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
        _videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        _videoCamera.defaultFPS =10;
        _videoCamera.grayscaleMode = NO;
        
    }
    
    return _videoCamera;
    
}

-(void)processImage:(Mat&)image; {
    Mat grayFrame, output;
    imageFrames_m2[frameCount_m2] = image;
    frameCount_m2++;
    
    if(frameCount_m2 == 48) {
        frame_m2 = [NSString stringWithFormat:@"%d", frameNumber_m2];
        frameNumber_m2 = frameNumber_m2 + 1;
        [appDelegate_m2 sendFramesAndWriteToFile:imageFrames_m2:frameCount_m2:"M2":pageLabel.text.UTF8String];
        frameCount_m2 = 0;
    }
    
}

#endif


- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    continueToQuizButton.hidden = YES;
    
    if([pageLabel.text isEqualToString:@"1"]) {
        pageViews_m2[0] = pageViews_m2[0] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m2 objectAtIndex:0];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m2 insertObject:newTime atIndex:0];
        [self startTimer];
    } else if([pageLabel.text isEqualToString:@"2"]) {
        pageViews_m2[1] = pageViews_m2[1] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m2 objectAtIndex:1];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m2 insertObject:newTime atIndex:1];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"3"]) {
        pageViews_m2[2] = pageViews_m2[2] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m2 objectAtIndex:2];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m2 insertObject:newTime atIndex:2];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"4"]) {
        pageViews_m2[3] = pageViews_m2[3] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m2 objectAtIndex:3];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m2 insertObject:newTime atIndex:3];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"5"]) {
        pageViews_m2[4] = pageViews_m2[4] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m2 objectAtIndex:4];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m2 insertObject:newTime atIndex:4];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"6"]) {
        pageViews_m2[5] = pageViews_m2[5] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m2 objectAtIndex:5];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m2 insertObject:newTime atIndex:5];
        [self startTimer];
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if ([pageLabel.text isEqualToString:@"6"] || [pageLabel.text isEqualToString:@"7"]) {
            [self performSelector:@selector(quizDelay) withObject:nil afterDelay:.5];
        }
        
        if (imageIndex_m2<[images_m2 count]-1) {
            imageIndex_m2++;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",imageIndex_m2+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images_m2 objectAtIndex:imageIndex_m2]];
        }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (imageIndex_m2>0) {
            imageIndex_m2--;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",imageIndex_m2+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromLeft]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images_m2 objectAtIndex:imageIndex_m2]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginModule:(id)sender {
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [image addGestureRecognizer:swipeLeft];
    [image addGestureRecognizer:swipeRight];
    
    image.image = [UIImage imageNamed:[images_m2 objectAtIndex:imageIndex_m2]];
    beginModuleButton.hidden = YES;
    pageLabel.text = [NSString stringWithFormat:@"%i",imageIndex_m2+1];
    [self startTimer];
}

- (IBAction)continueToQuiz:(id)sender {
    pageViews_m2[6] = pageViews_m2[6] + 1;
    NSNumber *currentTime = [self cancelTimer];
    NSNumber *oldTime = [timePerPage_m2 objectAtIndex:6];
    NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
    [timePerPage_m2 insertObject:newTime atIndex:6];
    
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    for (int i = 0; i < 7; i++) {
        NSLog(@"Visited page %i %i times and spent %@ seconds  there.",i+1,pageViews_m2[i],[timePerPage_m2 objectAtIndex:i]);
    }
    
    NSLog(@"Total time for Module 2: %f",total_m2);
    
    [self performSegueWithIdentifier: @"toQuiz2" sender: self];
}

-(void)quizDelay {
    continueToQuizButton.hidden = NO;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end