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
int swipedLeft_ta = 0;
NSTimer *transitionTimer_ta;
NSDate* startDate_ta;

NSTimeInterval total_ta;
NSString *swipeInterval_ta;
NSString *clickInterval_ta;
NSString *continueInterval_ta;
NSString *totalInterval_ta;




-(void) viewDidAppear:(BOOL)animated {
    [self startTimer];
}

- (NSString*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_ta];
    total_ta +=elapsedTime;
    NSString *interval = [NSString stringWithFormat:@"%f", elapsedTime];
    [transitionTimer_ta invalidate];
    return interval;
}

- (void)startTimer {
    startDate_ta = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_ta = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
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
        swipedLeft_ta = 1;
        swipe_image.image = [UIImage imageNamed:@"swipeLeft"];
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight && swipedLeft_ta == 1)  {
        swipe_image.image = [UIImage imageNamed:@"swipeRight"];
        swipeInterval_ta = [self cancelTimer];
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
    clickInterval_ta = [self cancelTimer];
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
    continueInterval_ta = [self cancelTimer];
    totalInterval_ta = [NSString stringWithFormat:@"%f", total_ta];
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    NSLog(@"Swipe Interval: %@",swipeInterval_ta);
    NSLog(@"Click Interval: %@",clickInterval_ta);
    NSLog(@"Continue Interval: %@",continueInterval_ta);
    NSLog(@"total_ta Interval: %@",totalInterval_ta);
    
    [self performSegueWithIdentifier:@"toModule1" sender:self];
}

@end
