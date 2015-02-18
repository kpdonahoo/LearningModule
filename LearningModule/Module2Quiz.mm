//
//  Module2Quiz.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module2Quiz.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif
#import "AppDelegate.h"

using namespace cv;

@interface Module2Quiz () <UIAlertViewDelegate, CvVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *toModule2;
@property (weak, nonatomic) IBOutlet UIButton *continueButton2;
@property (strong, nonatomic) UIView *cameraOutput;
@property (strong, nonatomic) CvVideoCamera* videoCamera;

@end

@implementation Module2Quiz
@synthesize cameraOutput;
@synthesize image;
@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize dButton;
@synthesize continueButton;
@synthesize continueButton2;
@synthesize toModule2;
@synthesize backButton;

NSArray *answers_q2;
NSArray *questions_q2;
NSArray *correctAnswers_q2;
NSArray *incorrect_q2;
int questionsIndex_q2;
UIAlertView *alert_q2;
NSMutableArray *timePerQuizPage_q2;
NSNumber *sum_q2;
NSTimer *transitionTimer_q2;
NSDate* startDate_q2;
NSMutableArray *answersToQuiz_q2;
Mat imageFrames_q2[48];
int frameCount_q2 = 0;
int frameNumber_q2 = 0;
NSString *frame_q2;
AppDelegate *appDelegate_q2;

- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_q2];
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_q2 invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_q2 = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_q2 = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoCamera start];
    appDelegate_q2 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    questionsIndex_q2 = 0;
    
    timePerQuizPage_q2 = [[NSMutableArray alloc] init];
    
    answersToQuiz_q2 = [[NSMutableArray alloc] init];
    
    answers_q2 = @[@"d",@"a",@"b"];
    questions_q2 = @[@"Module2Q1.png",@"Module2Q2.png",@"Module2Q3.png"];
    incorrect_q2 = @[@"Module2Q1I.png",@"Module2Q2I.png",@"Module2Q3I.png"];
    correctAnswers_q2 = @[@"Module2Q1C.png",@"Module2Q2C.png",@"Module2Q3C.png"];
    
    image.image = [UIImage imageNamed:[questions_q2 objectAtIndex:0]];
    [self performSelector:@selector(hideAD) withObject:nil afterDelay:.5];
    
     [self startTimer];
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
    imageFrames_q2[frameCount_q2] = image;
    frameCount_q2++;
    
    if(frameCount_q2 == 48) {
        frame_q2 = [NSString stringWithFormat:@"%d", frameNumber_q2];
        frameNumber_q2 = frameNumber_q2 + 1;
        NSString *qIIndex = [NSString stringWithFormat:@"%d", questionsIndex_q2];
        [appDelegate_q2 sendFramesAndWriteToFile:imageFrames_q2:frameCount_q2:"Q2":[qIIndex UTF8String]];
        frameCount_q2 = 0;
    }
    
}

#endif


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aClicked:(id)sender {
    [self checkAnswer:@"a"];
}

- (IBAction)bClicked:(id)sender {
    [self checkAnswer:@"b"];
}

- (IBAction)cClicked:(id)sender {
    [self checkAnswer:@"c"];
}

- (IBAction)dClicked:(id)sender {
    [self checkAnswer:@"d"];
}

-(void) checkAnswer:(NSString *) answer {
    
    NSNumber *currentTime = [self cancelTimer];
    [timePerQuizPage_q2 addObject:currentTime];
    [self startTimer];
    
    aButton.hidden = YES;
    bButton.hidden = YES;
    cButton.hidden = YES;
    dButton.hidden = YES;
    
    if ([answer isEqualToString:[answers_q2 objectAtIndex:questionsIndex_q2]]) {
        [answersToQuiz_q2 addObject:@"correct"];
        [self performSelector:@selector(hideButtonTwo) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[correctAnswers_q2 objectAtIndex:questionsIndex_q2]];
        
    } else {
        [answersToQuiz_q2 addObject:@"incorrect_q2"];
        [self performSelector:@selector(hideButtonOne) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        [[continueButton layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[incorrect_q2 objectAtIndex:questionsIndex_q2]];
    }
    
}

- (IBAction)continueButtonClicked:(id)sender {
    
    if (questionsIndex_q2 < 2) {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_q2 addObject:currentTime];
        [self startTimer];
    } else {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_q2 addObject:currentTime];
    }
    
    if(questionsIndex_q2 <=1) {
        questionsIndex_q2++;
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[questions_q2 objectAtIndex:questionsIndex_q2]];
        
        continueButton.Hidden = YES;
        continueButton2.Hidden = YES;
        
        
        if (questionsIndex_q2 == 1) {
            
            aButton.frame = CGRectMake(810, 480, 200, 95);
            [self performSelector:@selector(hideButtonA) withObject:nil afterDelay:.5];
            
            bButton.frame = CGRectMake(785, 620, 200, 95);
            aButton.imageView.image = [UIImage imageNamed:@"button.png"];
            [self performSelector:@selector(hideButtonB) withObject:nil afterDelay:.5];
        }
        
        if (questionsIndex_q2 == 2) {
            
            aButton.frame = CGRectMake(735, 470, 200, 95);
            [self performSelector:@selector(hideButtonA) withObject:nil afterDelay:.5];
            
            bButton.frame = CGRectMake(790, 625, 200, 95);
            aButton.imageView.image = [UIImage imageNamed:@"button.png"];
            [self performSelector:@selector(hideButtonB) withObject:nil afterDelay:.5];
        }
        
    } else {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:@"Module2Completed.png"];
        [self performSelector:@selector(hideModuleTransition) withObject:nil afterDelay:.5];
        continueButton2.hidden = YES;
        continueButton.hidden = YES;
    }
}

- (IBAction)toModule2:(id)sender {
    alert_q2 = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"\nModule 3 contains graphic content."  delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert_q2.tag = 1;
    [alert_q2 show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    
    for (int counter = 0; counter < 3; counter++) {
        NSLog(@"Question %i: %@",counter+1,[answersToQuiz_q2 objectAtIndex:counter]);
    }
    
    for (int i = 0; i < 6; i++) {
        NSLog(@"Spent %@ seconds on %i.",[timePerQuizPage_q2 objectAtIndex:i],i+1);
        NSNumber *currentTotal = [timePerQuizPage_q2 objectAtIndex:i];
        sum_q2 = [NSNumber numberWithFloat:([sum_q2 floatValue] + [currentTotal floatValue])];
    }
    NSLog(@"Total time for Module 2 Quiz: %@",sum_q2);
    NSString *qIIndex = [NSString stringWithFormat:@"%d", questionsIndex_q2];
    [appDelegate_q2 changeModuleAndHandleTimers:timePerQuizPage_q2:answersToQuiz_q2:@"Q2"];
    [appDelegate_q2 sendFramesAndWriteToFile:imageFrames_q2:frameCount_q2:"Q2":[qIIndex UTF8String]];
    [self performSegueWithIdentifier:@"toModule3" sender:self];
}

-(void) hideButtonOne {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0;
    [continueButton.layer addAnimation:animation forKey:nil];
    continueButton.hidden = NO;
}

-(void) hideButtonTwo {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0;
    [continueButton2.layer addAnimation:animation forKey:nil];
    continueButton2.hidden = NO;
}

-(void) hideButtonA {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [aButton.layer addAnimation:animation forKey:nil];
    aButton.hidden = NO;
}

-(void) hideButtonB {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [bButton.layer addAnimation:animation forKey:nil];
    bButton.hidden = NO;
}

-(void) hideModuleTransition {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [toModule2.layer addAnimation:animation forKey:nil];
    toModule2.hidden = NO;
    [backButton.layer addAnimation:animation forKey:nil];
    backButton.hidden = NO;
}
-(void) hideAD {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [toModule2.layer addAnimation:animation forKey:nil];
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

- (IBAction)backButton:(id)sender {
    [self performSegueWithIdentifier:@"backToModule2" sender:self];
}

@end

