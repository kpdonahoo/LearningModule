//
//  Module4.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module4.h"

@interface Module4 () <UIAlertViewDelegate>
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (weak, nonatomic) IBOutlet UIImageView *introImage;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

@end

@implementation Module4
@synthesize player;
@synthesize introImage;
@synthesize continueButton;
UIAlertView *alert_m4;
float lastPlayback_m4 = 0.0;
float currentPlayback_m4 = 0.0;

- (void)viewDidLoad {
}

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
