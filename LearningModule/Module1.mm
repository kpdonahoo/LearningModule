//
//  Module1.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/6/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module1.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif

#import "AppDelegate.h"

using namespace cv;

@interface Module1 () <CvVideoCameraDelegate>
@property (strong, nonatomic) CvVideoCamera* videoCamera;
@property (weak, nonatomic) IBOutlet UIButton *beginModuleButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *continueToQuizButton;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) UIView *cameraOutput;

@end

@implementation Module1
@synthesize cameraOutput;
@synthesize image;
@synthesize beginModuleButton;
@synthesize continueToQuizButton;
@synthesize pageLabel;
NSArray *images;
int image_index;
int pageViews[11];
NSMutableArray *timePerPage;
NSTimeInterval totalMod1;
NSTimer *transitionTimer;
NSDate* startDate;
AppDelegate *appDelegate;

Mat imageFrames[48];
int frameCount = 0;
int frameNumber = 0;
NSString *frame;

- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate];
    totalMod1 +=elapsedTime;
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoCamera start];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [image setUserInteractionEnabled:YES];
    NSNumber *dummy = @0;
    timePerPage = [[NSMutableArray alloc] init];
    cameraOutput = [[UIView alloc] init];
    
    for (int counter = 0; counter < 11; counter++) {
        [timePerPage addObject:dummy];
    }
    
    UIFont *font = [UIFont fontWithName:@"PTSans-Regular" size:18];
    pageLabel.font = font;
    image_index = 0;
    
    images = @[@"Module1-1 copy.png",@"Module1-2 copy.png",@"Module1-3 copy.png",@"Module1-4 copy.png",@"Module1-5 copy.png",@"Module1-6 copy.png",@"Module1-7 copy.png",@"Module1-8 copy.png",@"Module1-9 copy.png",@"Module1-10 copy.png",@"Module1-11 copy.png",];
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
    imageFrames[frameCount] = image;
    frameCount++;
    
    if(frameCount == 48) {
        frame = [NSString stringWithFormat:@"%d", frameNumber];
        frameNumber = frameNumber + 1;
        [appDelegate sendFramesAndWriteToFile:imageFrames:frameCount:"M1":pageLabel.text.UTF8String];
        frameCount = 0;
    }
  
}

#endif

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
        continueToQuizButton.hidden = YES;
    
    if([pageLabel.text isEqualToString:@"1"]) {
        pageViews[0] = pageViews[0] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:0];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:0];
        [self startTimer];
    } else if([pageLabel.text isEqualToString:@"2"]) {
        pageViews[1] = pageViews[1] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:1];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:1];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"3"]) {
        pageViews[2] = pageViews[2] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:2];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:2];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"4"]) {
        pageViews[3] = pageViews[3] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:3];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:3];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"5"]) {
        pageViews[4] = pageViews[4] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:4];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:4];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"6"]) {
        pageViews[5] = pageViews[5] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:5];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:5];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"7"]) {
        pageViews[6] = pageViews[6] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:6];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:6];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"8"]) {
        pageViews[7] = pageViews[7] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:7];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:7];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"9"]) {
        pageViews[8] = pageViews[8] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:8];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:8];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"10"]) {
        pageViews[9] = pageViews[9] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage objectAtIndex:9];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage insertObject:newTime atIndex:9];
        [self startTimer];
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if ([pageLabel.text isEqualToString:@"10"] || [pageLabel.text isEqualToString:@"11"]) {
            continueToQuizButton.hidden = NO;
        }
        
        if (image_index<[images count]-1) {
            image_index++;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",image_index+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
    }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (image_index>0) {
            image_index--;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",image_index+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromLeft]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
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
    image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
    beginModuleButton.hidden = YES;
    pageLabel.text = [NSString stringWithFormat:@"%i",image_index+1];
    [self startTimer];
}

- (IBAction)continueToQuiz:(id)sender {
    pageViews[10] = pageViews[10] + 1;
    NSNumber *currentTime = [self cancelTimer];
    NSNumber *oldTime = [timePerPage objectAtIndex:10];
    NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
    [timePerPage insertObject:newTime atIndex:10];
    
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    for (int i = 0; i < 11; i++) {
        NSLog(@"Visited page %i %i times and spent %@ seconds  there.",i+1,pageViews[i],[timePerPage objectAtIndex:i]);
    }
    NSLog(@"Total time for Module 1: %f",totalMod1);
    [appDelegate changeModuleAndHandleTimers:timePerPage:nullptr:@"M1"];
    [appDelegate sendFramesAndWriteToFile:imageFrames:frameCount:"M1":pageLabel.text.UTF8String];
    [self performSegueWithIdentifier: @"toQuiz" sender: self];
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
