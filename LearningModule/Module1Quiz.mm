//
//  Module1Quiz.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module1Quiz.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif
#import "AppDelegate.h"

using namespace cv;

@interface Module1Quiz () <UIAlertViewDelegate, CvVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *toModule2;
@property (weak, nonatomic) IBOutlet UIButton *continueButton2;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) UIView *cameraOutput;
@property (strong, nonatomic) CvVideoCamera* videoCamera;

@end

@implementation Module1Quiz
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

NSArray *answers_q1;
NSArray *questions_q1;
NSArray *correctAnswers_q1;
NSArray *incorrect_q1;
int questionsIndex_q1;
UIAlertView *alert_q1;
NSMutableArray *timePerQuizPage_q1;
NSNumber *sum_q1;
NSTimer *transitionTimer_q1;
NSDate* startDate_q1;
NSMutableArray *answersToQuiz_q1;
Mat imageFrames_q1[48];
int frameCount_q1 = 0;
int frameNumber_q1 = 0;
NSString *frame_q1;
AppDelegate *appDelegate_q1;


- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_q1];
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_q1 invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_q1 = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_q1 = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoCamera start];
    appDelegate_q1 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    questionsIndex_q1 = 0;
    
    timePerQuizPage_q1 = [[NSMutableArray alloc] init];
    
    answersToQuiz_q1 = [[NSMutableArray alloc] init];
    
    answers_q1 = @[@"b",@"a",@"a"];
    questions_q1 = @[@"Module1Q1.png",@"Module1Q2.png",@"Module1Q3.png"];
    incorrect_q1 = @[@"Module1Q1I.png",@"Module1Q2I.png",@"Module1Q3I.png"];
    correctAnswers_q1 = @[@"Module1Q1C.png",@"Module1Q2C.png",@"Module1Q3C.png"];
    
    image.image = [UIImage imageNamed:[questions_q1 objectAtIndex:0]];
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
    imageFrames_q1[frameCount_q1] = image;
    frameCount_q1++;
    
    if(frameCount_q1 == 48) {
        frame_q1 = [NSString stringWithFormat:@"%d", frameNumber_q1];
        frameNumber_q1 = frameNumber_q1 + 1;
        NSString *qIIndex = [NSString stringWithFormat:@"%d", questionsIndex_q1];
        [appDelegate_q1 sendFramesAndWriteToFile:imageFrames_q1:frameCount_q1:"Q1":[qIIndex UTF8String]];
        frameCount_q1 = 0;
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
    [timePerQuizPage_q1 addObject:currentTime];
    [self startTimer];

    aButton.hidden = YES;
    bButton.hidden = YES;
    cButton.hidden = YES;
    dButton.hidden = YES;
    
    if ([answer isEqualToString:[answers_q1 objectAtIndex:questionsIndex_q1]]) {
        [answersToQuiz_q1 addObject:@"correct"];
        [self performSelector:@selector(hideButtonTwo) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[correctAnswers_q1 objectAtIndex:questionsIndex_q1]];
        
    } else {
        [answersToQuiz_q1 addObject:@"incorrect_q1"];
        [self performSelector:@selector(hideButtonOne) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        [[continueButton layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[incorrect_q1 objectAtIndex:questionsIndex_q1]];
    }
    
}

- (IBAction)continueButtonClicked:(id)sender {
    
    if (questionsIndex_q1 < 2) {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_q1 addObject:currentTime];
        [self startTimer];
    } else {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_q1 addObject:currentTime];
    }
    
    if(questionsIndex_q1 <=1) {
    questionsIndex_q1++;
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
    [animation setType:kCATransitionPush]; //New image will push the old image off
    [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.image layer] addAnimation:animation forKey:nil];
    
    image.image = [UIImage imageNamed:[questions_q1 objectAtIndex:questionsIndex_q1]];
        
    continueButton.Hidden = YES;
    continueButton2.Hidden = YES;
        
    
    if (questionsIndex_q1 > 0) {
        
        aButton.frame = CGRectMake(810, 505, 200, 95);
        [self performSelector:@selector(hideButtonA) withObject:nil afterDelay:.5];
        
        bButton.frame = CGRectMake(775, 607, 200, 95);
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
        
        image.image = [UIImage imageNamed:@"Module1Completed.png"];
        [self performSelector:@selector(hideModuleTransition) withObject:nil afterDelay:.5];
        continueButton2.hidden = YES;
        continueButton.hidden = YES;
    }
}
- (IBAction)toModule1:(id)sender {
    [self performSegueWithIdentifier:@"toModule1" sender:self];
}

- (IBAction)toModule2:(id)sender {
    alert_q1 = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"\nModule 2 contains graphic content."  delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert_q1.tag = 1;
    [alert_q1 show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    
    for (int counter = 0; counter < 3; counter++) {
        NSLog(@"Question %i: %@",counter+1,[answersToQuiz_q1 objectAtIndex:counter]);
    }
    
    for (int i = 0; i < 6; i++) {
        NSLog(@"Spent %@ seconds on %i.",[timePerQuizPage_q1 objectAtIndex:i],i+1);
        NSNumber *currentTotal = [timePerQuizPage_q1 objectAtIndex:i];
        sum_q1 = [NSNumber numberWithFloat:([sum_q1 floatValue] + [currentTotal floatValue])];
    }
    NSLog(@"Total time for Module 1 Quiz: %@",sum_q1);
    NSString *qIIndex = [NSString stringWithFormat:@"%d", questionsIndex_q1];
    [appDelegate_q1 changeModuleAndHandleTimers:timePerQuizPage_q1:answersToQuiz_q1:@"Q1"];
    [appDelegate_q1 sendFramesAndWriteToFile:imageFrames_q1:frameCount_q1:"Q1":[qIIndex UTF8String]];
    [self performSegueWithIdentifier:@"toModule2" sender:self];
    
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
    [backButton.layer addAnimation:animation forKey:nil];
    toModule2.hidden = NO;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
