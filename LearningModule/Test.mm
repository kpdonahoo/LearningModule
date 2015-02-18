//
//  Test.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/8/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Test.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif
#import "AppDelegate.h"

using namespace cv;

@interface Test () <CvVideoCameraDelegate>
@property (weak, nonatomic) IBOutlet UIButton *secretButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *toTest;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UIButton *eButton;
@property (weak, nonatomic) IBOutlet UIButton *fButton;
@property (weak, nonatomic) IBOutlet UIButton *negButton;
@property (weak, nonatomic) IBOutlet UIButton *posButton;
@property (weak, nonatomic) IBOutlet UIButton *invButton;
@property (strong, nonatomic) UIView *cameraOutput;
@property (strong, nonatomic) CvVideoCamera* videoCamera;

@end

@implementation Test
@synthesize cameraOutput;
@synthesize image;
@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize dButton;
@synthesize eButton;
@synthesize fButton;
@synthesize continueButton;
@synthesize toTest;
@synthesize scoreLabel;
@synthesize negButton;
@synthesize posButton;
@synthesize invButton;
@synthesize secretButton;

NSArray *answers_te;
NSArray *questions_te;
NSMutableArray *userAnswers_te;
int questionsIndex_te;
int numberCorrect_te = 0;
NSMutableArray *timePerTestPage_te;
NSNumber *sum_te;
NSTimer *transitionTimer_te;
NSDate* startDate_te;
NSMutableArray *answersToTest_te;
NSMutableArray *correctOrIncorrect_te;
Mat imageFrames_te[48];
int frameCount_te = 0;
int frameNumber_te = 0;
NSString *frame_te;
AppDelegate *appDelegate_te;


- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_te];
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_te invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_te = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_te = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.videoCamera start];
    appDelegate_te = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    userAnswers_te = [[NSMutableArray alloc] init];
    
    timePerTestPage_te = [[NSMutableArray alloc] init];
    
    correctOrIncorrect_te = [[NSMutableArray alloc] init];
    
    [self startTimer];
    
    questionsIndex_te = 0;
    
    answers_te = @[@"a",@"d",@"e",@"b",@"f",@"b",@"d",@"c",@"c",@"d",@"b",@"a",@"c",@"a",@"b",@"c"];
    questions_te = @[@"Q1.png",@"Q2.png",@"Q3.png",@"Q4.png",@"Q5.png",@"Q6.png",@"Q7.png",@"Q8.png",@"Q9.png",@"Q10.png",@"Q11.png",@"Q12.png",@"Q13.png",@"Q14.png",@"Q15.png",@"Q16.png"];
    
    image.image = [UIImage imageNamed:[questions_te objectAtIndex:0]];
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
    imageFrames_te[frameCount_te] = image;
    frameCount_te++;
    
    if(frameCount_te == 48) {
        frame_te = [NSString stringWithFormat:@"%d", frameNumber_te];
        frameNumber_te = frameNumber_te + 1;
        NSString *qIIndex = [NSString stringWithFormat:@"%d", questionsIndex_te];
        [appDelegate_te sendFramesAndWriteToFile:imageFrames_te:frameCount_te:"TE":[qIIndex UTF8String]];
        frameCount_te = 0;
    }
    
}

#endif


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aClicked:(id)sender {
    [userAnswers_te addObject:@"a"];
    NSLog(@"%@",userAnswers_te);
    [self continueTest];
}

- (IBAction)bClicked:(id)sender {
    [userAnswers_te addObject:@"b"];
    NSLog(@"%@",userAnswers_te);
    [self continueTest];
}

- (IBAction)cClicked:(id)sender {
    [userAnswers_te addObject:@"c"];
    NSLog(@"%@",userAnswers_te);
    [self continueTest];
}

- (IBAction)dClicked:(id)sender {
    [userAnswers_te addObject:@"d"];
    NSLog(@"%@",userAnswers_te);
    [self continueTest];
}

- (IBAction)eClicked:(id)sender {
    [userAnswers_te addObject:@"e"];
    NSLog(@"%@",userAnswers_te);
    [self continueTest];
}

- (IBAction)fClicked:(id)sender {
    [userAnswers_te addObject:@"f"];
    NSLog(@"%@",userAnswers_te);
    [self continueTest];
}

-(void) continueTest {
    
    if(questionsIndex_te <=14) {
        NSNumber *currentTime = [self cancelTimer];
        [timePerTestPage_te addObject:currentTime];
        [self startTimer];
        questionsIndex_te++;
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[questions_te objectAtIndex:questionsIndex_te]];
        
        if(questionsIndex_te == 1) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q2) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 2) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q3) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te ==3) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q4) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 4) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q5) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 5) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q6) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 6) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q7) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 7) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q8) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 8) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q9) withObject:nil afterDelay:.5];
        } else if (questionsIndex_te == 9) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q10) withObject:nil afterDelay:.5];
        } else {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(rest) withObject:nil afterDelay:.5];
        }
        
    } else {
        
        NSNumber *currentTime = [self cancelTimer];
        [timePerTestPage_te addObject:currentTime];
        
        for (int counter = 0; counter < [answers_te count]; counter++) {
            if([[answers_te objectAtIndex:counter] isEqualToString:[userAnswers_te objectAtIndex:counter]]) {
                [correctOrIncorrect_te addObject:@"correct"];
                numberCorrect_te++;
            } else {
                [correctOrIncorrect_te addObject:@"incorrect"];
            }
        }
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        secretButton.hidden = NO;
        
        image.image = [UIImage imageNamed:@"ModuleCompleted.png"];
        aButton.hidden = YES;
        bButton.hidden = YES;
        cButton.hidden = YES;
        dButton.hidden = YES;
        negButton.hidden = YES;
        posButton.hidden = YES;
        invButton.hidden = YES;
        
        /*SEND TO SERVER HERE*/
        NSLog(@"SENDING TO SERVER:");
        
        for (int counter = 0; counter < 15; counter++) {
            NSLog(@"Question %i: %@",counter+1,[correctOrIncorrect_te objectAtIndex:counter]);
        }
        
        for (int i = 0; i < 15; i++) {
            NSLog(@"Spent %@ seconds on %i.",[timePerTestPage_te objectAtIndex:i],i+1);
            NSNumber *currentTotal = [timePerTestPage_te objectAtIndex:i];
            sum_te = [NSNumber numberWithFloat:([sum_te floatValue] + [currentTotal floatValue])];
        }
        NSLog(@"Total time for Test: %@",sum_te);
        
        int score = numberCorrect_te/16.0 * 100.0;
        
        NSLog(@"Score: %i",score);
        NSString *qIIndex = [NSString stringWithFormat:@"%d", questionsIndex_te];
        [appDelegate_te changeModuleAndHandleTimers:timePerTestPage_te:answersToTest_te:@"TE"];
        [appDelegate_te sendFramesAndWriteToFile:imageFrames_te:frameCount_te:"TE":[qIIndex UTF8String]];
        scoreLabel.font = [UIFont fontWithName:@"PTSans-Regular" size:60];
        scoreLabel.text = [NSString stringWithFormat:@"%d",score];
        
    }

    
}

-(void) Q2 {
    aButton.frame = CGRectMake(700,387,187,93);
    bButton.frame = CGRectMake(826,460,187,93);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q3 {
    aButton.frame = CGRectMake(782,368,91,57);
    bButton.frame = CGRectMake(844,420,91,57);
    cButton.frame = CGRectMake(845,490,91,57);
    dButton.frame = CGRectMake(223,560,91,57);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = NO;
    fButton.hidden = NO;
    eButton.frame = CGRectMake(223,610,91,57);
    fButton.frame = CGRectMake(239,660,91,57);
}

-(void) Q4 {
    aButton.frame = CGRectMake(448,387,146,89);
    bButton.frame = CGRectMake(446,462,146,89);
    cButton.frame = CGRectMake(467,535,146,89);
    dButton.frame = CGRectMake(467,611,146,89);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = YES;
    fButton.hidden = YES;
}

-(void) Q5 {
    aButton.frame = CGRectMake(382,362,119,73);
    bButton.frame = CGRectMake(307,420,119,73);
    cButton.frame = CGRectMake(452,472,119,73);
    dButton.frame = CGRectMake(869,528,119,73);
    eButton.frame = CGRectMake(288,610,119,73);
    fButton.frame = CGRectMake(251,663,119,73);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = NO;
    fButton.hidden = NO;
}

-(void) Q6 {
    aButton.frame = CGRectMake(837,393,131,72);
    bButton.frame = CGRectMake(755,469,131,72);
    cButton.frame = CGRectMake(672,542,131,72);
    dButton.frame = CGRectMake(830,617,131,72);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = YES;
    fButton.hidden = YES;
}

-(void) Q7 {
    aButton.frame = CGRectMake(837,396,134,70);
    bButton.frame = CGRectMake(821,470,134,70);
    cButton.frame = CGRectMake(577,546,134,70);
    dButton.frame = CGRectMake(669,612,134,70);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q8 {
    aButton.frame = CGRectMake(820,384,143,88);
    bButton.frame = CGRectMake(737,461,143,88);
    cButton.frame = CGRectMake(821,538,143,88);
    dButton.frame = CGRectMake(742,602,143,88);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q9 {
    aButton.frame = CGRectMake(165,392,187,93);
    bButton.frame = CGRectMake(165,462,187,93);
    cButton.frame = CGRectMake(165,536,187,93);
    dButton.frame = CGRectMake(165,608,187,93);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q10 {
    aButton.frame = CGRectMake(799,404,146,78);
    bButton.frame = CGRectMake(831,476,146,78);
    cButton.frame = CGRectMake(709,567,146,78);
    dButton.frame = CGRectMake(816,626,146,78);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) rest {
    negButton.hidden = NO;
    posButton.hidden = NO;
    invButton.hidden = NO;
}


- (IBAction)toTest:(id)sender {
    [self performSegueWithIdentifier:@"toTest" sender:self];
}

-(void) showTest {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [toTest.layer addAnimation:animation forKey:nil];
    toTest.hidden = NO;
}



- (IBAction)secretButtonClicked:(id)sender {
    
    NSLog(@"get participant ID for self-assessment and exit interview");
}

@end
