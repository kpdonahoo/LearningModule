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
UIAlertView *alert;
float lastPlayback = 0.0;
float currentPlayback = 0.0;

- (void)viewDidLoad {
}

- (IBAction)startModule:(id)sender {
    
    alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"\nModule 4 contains graphic content."  delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert.tag = 1;
    [alert show];
    
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
        
        currentPlayback = player.currentPlaybackTime;
        
        NSLog(@"Playing at %f",player.currentPlaybackTime);
        if (currentPlayback > lastPlayback) {
            NSLog(@"Fast Forwarded to %f",currentPlayback);
        } else {
            NSLog(@"Rewinded to %f",player.currentPlaybackTime);
        }
        
        lastPlayback = currentPlayback;
        
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
    alert = [[UIAlertView alloc] initWithTitle:@"Continue to Video Quiz?" message:@"\nYou cannot return to the video once you start the quiz."  delegate:self cancelButtonTitle:@"Rewatch Video" otherButtonTitles: @"Continue", nil];
    alert.tag = 2;
    [alert show];

}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alert.tag == 1) {
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
