//
//  Module3Quiz.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module3Quiz.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif
#import "AppDelegate.h"

using namespace cv;

@interface Module3Quiz () <CvVideoCameraDelegate>
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

@implementation Module3Quiz
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

NSArray *answers_q3;
NSArray *questions_q3;
NSArray *correctAnswers_q3;
NSArray *incorrect_q3;
int questionsIndex_q3;
NSMutableArray *timePerQuizPage_q3;
NSNumber *sum_q3;
NSTimer *transitionTimer_q3;
NSDate* startDate_q3;
NSMutableArray *answersToQuiz_q3;
Mat imageFrames_q3[48];
int frameCount_q3 = 0;
int frameNumber_q3 = 0;
NSString *frame_q3;
AppDelegate *appDelegate_q3;


- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_q3];
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_q3 invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_q3 = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_q3 = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoCamera start];
    appDelegate_q3 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    questionsIndex_q3 = 0;
    
    timePerQuizPage_q3 = [[NSMutableArray alloc] init];
    
    answersToQuiz_q3 = [[NSMutableArray alloc] init];

    answers_q3 = @[@"b",@"b",@"a"];
    questions_q3 = @[@"Module3Q1.png",@"Module3Q2.png",@"Module3Q3.png"];
    incorrect_q3 = @[@"Module3Q1I.png",@"Module3Q2I.png",@"Module3Q3I.png"];
    correctAnswers_q3 = @[@"Module3Q1C.png",@"Module3Q2C.png",@"Module3Q3C.png"];
    
    image.image = [UIImage imageNamed:[questions_q3 objectAtIndex:0]];
    [self performSelector:@selector(hideAD) withObject:nil afterDelay:.5];
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
    imageFrames_q3[frameCount_q3] = image;
    frameCount_q3++;
    
    if(frameCount_q3 == 48) {
        frame_q3 = [NSString stringWithFormat:@"%d", frameNumber_q3];
        frameNumber_q3 = frameNumber_q3 + 1;
        [appDelegate_q3 sendFramesAndWriteToFile:imageFrames_q3:frameCount_q3:"Q3":""];
        frameCount_q3 = 0;
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
    [timePerQuizPage_q3 addObject:currentTime];
    [self startTimer];
    
    aButton.hidden = YES;
    bButton.hidden = YES;
    cButton.hidden = YES;
    dButton.hidden = YES;
    
    if ([answer isEqualToString:[answers_q3 objectAtIndex:questionsIndex_q3]]) {
        [answersToQuiz_q3 addObject:@"correct"];
        [self performSelector:@selector(hideButtonTwo) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[correctAnswers_q3 objectAtIndex:questionsIndex_q3]];
        
    } else {
        [self performSelector:@selector(hideButtonOne) withObject:nil afterDelay:.5];
        [answersToQuiz_q3 addObject:@"incorrect_q3"];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        [[continueButton layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[incorrect_q3 objectAtIndex:questionsIndex_q3]];
    }
    
}

- (IBAction)continueButtonClicked:(id)sender {
    
    if (questionsIndex_q3 < 2) {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_q3 addObject:currentTime];
        [self startTimer];
    } else {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_q3 addObject:currentTime];
    }
    
    if(questionsIndex_q3 <=1) {
        questionsIndex_q3++;
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[questions_q3 objectAtIndex:questionsIndex_q3]];
        
        continueButton.Hidden = YES;
        continueButton2.Hidden = YES;
        
        
        if (questionsIndex_q3 == 1) {
            
            aButton.frame = CGRectMake(810, 480, 200, 95);
            [self performSelector:@selector(hideButtonA) withObject:nil afterDelay:.5];
            
            bButton.frame = CGRectMake(785, 620, 200, 95);
            aButton.imageView.image = [UIImage imageNamed:@"button.png"];
            [self performSelector:@selector(hideButtonB) withObject:nil afterDelay:.5];
        }
        
        if (questionsIndex_q3 == 2) {
            
            aButton.frame = CGRectMake(165, 470, 200, 95);
            [self performSelector:@selector(hideButtonA) withObject:nil afterDelay:.5];
            
            bButton.frame = CGRectMake(255, 555, 200, 95);
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
        
        image.image = [UIImage imageNamed:@"Module3Completed.png"];
        [self performSelector:@selector(hideModuleTransition) withObject:nil afterDelay:.5];
        continueButton2.hidden = YES;
        continueButton.hidden = YES;
    }
}

- (IBAction)toModule2:(id)sender {
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    
    for (int counter = 0; counter < 3; counter++) {
        NSLog(@"Question %i: %@",counter+1,[answersToQuiz_q3 objectAtIndex:counter]);
    }
    
    for (int i = 0; i < 6; i++) {
        NSLog(@"Spent %@ seconds on %i.",[timePerQuizPage_q3 objectAtIndex:i],i+1);
        NSNumber *currentTotal = [timePerQuizPage_q3 objectAtIndex:i];
        sum_q3 = [NSNumber numberWithFloat:([sum_q3 floatValue] + [currentTotal floatValue])];
    }
    NSLog(@"Total time for Module 3 Quiz: %@",sum_q3);
    
    [self performSegueWithIdentifier:@"toModule4" sender:self];
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

- (IBAction)backButton:(id)sender {
    [self performSegueWithIdentifier:@"backToModule3" sender:self];
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
