//
//  Module4.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module4.h"

@interface Module4 ()
@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation Module4
@synthesize player;

- (void)viewDidLoad {
    [self playMovie];
}

-(void) playMovie {

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"IARC" withExtension:@"mp4"];
    player = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [self.view addSubview:player.view];
    player.controlStyle = MPMovieControlStyleFullscreen;
    player.fullscreen = YES;
    player.shouldAutoplay = YES;
    [[player view] setFrame:[self.view bounds]]; // size to fit parent view exactly
    [self.view addSubview:[player view]];
    [player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(MPMoviePlayerPlaybackStateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification
                                               object:nil];
}

- (void)MPMoviePlayerPlaybackStateDidChange:(NSNotification *)notification
{
    if (player.playbackState == MPMoviePlaybackStatePlaying)
    {
        NSLog(@"Playing");
    }
    if (player.playbackState == MPMoviePlaybackStateStopped)
    {
        NSLog(@"Stopped");
    }if (player.playbackState == MPMoviePlaybackStatePaused)
    {
        NSLog(@"Paused");
    }if (player.playbackState == MPMoviePlaybackStateInterrupted)
    {
        NSLog(@"Interrupted");
    }if (player.playbackState == MPMoviePlaybackStateSeekingForward)
    {
        NSLog(@"Seeking Forward");
    }if (player.playbackState == MPMoviePlaybackStateSeekingBackward)
    {
        NSLog(@"Seeking Backward");
    }
    
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification {

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
