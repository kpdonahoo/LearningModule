//
//  TechAssessment.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/8/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "TechAssessment.h"

@interface TechAssessment ()
@property (weak, nonatomic) IBOutlet UIImageView *space;
@property (weak, nonatomic) IBOutlet UIImageView *swipe_image;
@property (weak, nonatomic) IBOutlet UIButton *penguin;
@property (weak, nonatomic) IBOutlet UIButton *toModule1;
@property (weak, nonatomic) IBOutlet UIImageView *techCopy;

@end

@implementation TechAssessment
@synthesize space;
@synthesize swipe_image;
@synthesize penguin;
@synthesize toModule1;
@synthesize techCopy;
int swipedLeft = 0;
NSTimer *transitionTimer;
NSDate* startDate;

NSTimeInterval total;
NSString *swipeInterval;
NSString *clickInterval;
NSString *continueInterval;
NSString *totalInterval;




-(void) viewDidAppear:(BOOL)animated {
    [self startTimer];
}

- (NSString*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate];
    total +=elapsedTime;
    NSString *interval = [NSString stringWithFormat:@"%f", elapsedTime];
    [transitionTimer invalidate];
    return interval;
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
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [space addGestureRecognizer:swipeLeft];
    [space addGestureRecognizer:swipeRight];
    
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        swipedLeft = 1;
        swipe_image.image = [UIImage imageNamed:@"swipeLeft"];
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight && swipedLeft == 1)  {
        swipe_image.image = [UIImage imageNamed:@"swipeRight"];
        swipeInterval = [self cancelTimer];
        [self performSelector:@selector(delaySwipe) withObject:nil afterDelay:.5];
        
    }
}

-(void) delaySwipe {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [swipe_image.layer addAnimation:animation forKey:nil];
    swipe_image.image= [UIImage imageNamed:@"click.png"];
    techCopy.image= [UIImage imageNamed:@"clickCopy.png"];
    penguin.hidden = NO;
    [self startTimer];
}

- (IBAction)penguinClicked:(id)sender {
    clickInterval = [self cancelTimer];
    penguin.hidden = TRUE;
    techCopy.hidden = YES;
    swipe_image.frame = CGRectMake(223,195,578,440);
    swipe_image.image = [UIImage imageNamed:@"techBoxLast.png"];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 1;
    [toModule1.layer addAnimation:animation forKey:nil];
    toModule1.hidden = NO;
    [self startTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toModule1Clicked:(id)sender {
    continueInterval = [self cancelTimer];
    totalInterval = [NSString stringWithFormat:@"%f", total];
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    NSLog(@"Swipe Interval: %@",swipeInterval);
    NSLog(@"Click Interval: %@",clickInterval);
    NSLog(@"Continue Interval: %@",continueInterval);
    NSLog(@"Total Interval: %@",totalInterval);
    
    [self performSegueWithIdentifier:@"toModule1" sender:self];
}

@end
