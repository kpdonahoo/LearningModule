//
//  Module4.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module4.h"
#ifdef __cplusplus
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/core/core.hpp>
#endif
#import "AppDelegate.h"

using namespace cv;

@interface Module4 () <UIAlertViewDelegate, CvVideoCameraDelegate>
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIImageView *introImage;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (strong, nonatomic) UIView *cameraOutput;
@property (strong, nonatomic) CvVideoCamera* videoCamera;

@end

@implementation Module4
@synthesize cameraOutput;
@synthesize player;
@synthesize introImage;
@synthesize continueButton;

UIAlertView *alert_m4;
float lastPlayback_m4 = 0.0;
float currentPlayback_m4 = 0.0;
Mat imageFrames_m4[48];
int frameCount_m4 = 0;
int frameNumber_m4 = 0;
NSString *frame_m4;
AppDelegate *appDelegate_m4;


- (void)viewDidLoad {
    
    [self.videoCamera start];
    appDelegate_m4 = (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    imageFrames_m4[frameCount_m4] = image;
    frameCount_m4++;
    
    if(frameCount_m4 == 48) {
        frame_m4 = [NSString stringWithFormat:@"%d", frameNumber_m4];
        frameNumber_m4 = frameNumber_m4 + 1;
        [appDelegate_m4 sendFramesAndWriteToFile:imageFrames_m4:frameCount_m4:"M4":"video"];
        frameCount_m4 = 0;
    }
    
}

#endif


- (IBAction)startModule:(id)sender {
    
    alert_m4 = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"\nModule 4 contains graphic content."  delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert_m4.tag = 1;
    [alert_m4 show];
    
}

- (IBAction)warningContinue:(id)sender {
    [self playMovie];
}

-(void) playMovie {

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"IARC" withExtension:@"mp4"];
    player = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self.view addSubview:player.view];
    player.controlStyle = MPMovieControlStyleEmbedded;
    player.shouldAutoplay = YES;
    [[player view] setFrame:[self.view bounds]]; // size to fit parent view exactly
    [self.view addSubview:[player view]];
    [player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MPMoviePlayerPlaybackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:player];
}

- (void)MPMoviePlayerPlaybackStateDidChange:(NSNotification *)notification
{
    if (player.playbackState == MPMoviePlaybackStatePlaying)
    {
        
        currentPlayback_m4 = player.currentPlaybackTime;
        
        NSLog(@"Playing at %f",player.currentPlaybackTime);
        if (currentPlayback_m4 > lastPlayback_m4) {
            NSLog(@"Fast Forwarded to %f",currentPlayback_m4);
        } else {
            NSLog(@"Rewinded to %f",player.currentPlaybackTime);
        }
        
        lastPlayback_m4 = currentPlayback_m4;
        
    }
    
    if (player.playbackState == MPMoviePlaybackStateStopped)
    {
        NSLog(@"Stopped");
    }
    
    if (player.playbackState == MPMoviePlaybackStatePaused)
    {
         NSLog(@"Paused at %f",player.currentPlaybackTime);
    }
    
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    alert_m4 = [[UIAlertView alloc] initWithTitle:@"Continue to Video Quiz?" message:@"\nYou cannot return to the video once you start the quiz."  delegate:self cancelButtonTitle:@"Rewatch Video" otherButtonTitles: @"Continue", nil];
    alert_m4.tag = 2;
    [alert_m4 show];

}

- (void)alert_m4View:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alert_m4.tag == 1) {
        [self playMovie];
    } else {
        if (buttonIndex == 0)
        {
            player.currentPlaybackTime = 0.0;
            [player play];
            
        }
        else
        {
            [self performSegueWithIdentifier:@"toVideoQuiz" sender:self];
        }

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
