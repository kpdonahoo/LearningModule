//
//  Module3.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module3.h"

@interface Module3 ()
@property (weak, nonatomic) IBOutlet UIButton *beginModuleButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *continueToQuizButton;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

@end

@implementation Module3

@synthesize image;
@synthesize beginModuleButton;
@synthesize continueToQuizButton;
@synthesize pageLabel;
NSArray *images_m3;
int imageIndex_m3;
int pageViews_m3[11];
NSMutableArray *timePerPage_m3;
NSTimeInterval total_m3;
NSTimer *transitionTimer_m3;
NSDate* startDate_m3;


- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_m3];
    total_m3 +=elapsedTime;
    NSLog(@"%f",total_m3);
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_m3 invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_m3 = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_m3 = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [image setUserInteractionEnabled:YES];
    NSNumber *dummy = @0;
    timePerPage_m3 = [[NSMutableArray alloc] init];
    
    for (int counter = 0; counter < 11; counter++) {
        [timePerPage_m3 addObject:dummy];
    }
    
    for (int counter = 0; counter < 11; counter++) {
        pageViews_m3[counter] = 0;
    }

    
    [image setUserInteractionEnabled:YES];
    
    UIFont *font = [UIFont fontWithName:@"PTSans-Regular" size:18];
    pageLabel.font = font;
    imageIndex_m3 = 0;
    
    images_m3 = @[@"Module3-1.png",@"Module3-2.png",@"Module3-3.png",@"Module3-4.png",@"Module3-5.png",@"Module3-6.png",@"Module3-7.png",@"Module3-8.png",@"Module3-9.png",@"Module3-10.png",@"Module3-11.png"];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    continueToQuizButton.hidden = YES;
    
    if([pageLabel.text isEqualToString:@"1"]) {
        pageViews_m3[0] = pageViews_m3[0] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:0];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:0];
        [self startTimer];
    } else if([pageLabel.text isEqualToString:@"2"]) {
        pageViews_m3[1] = pageViews_m3[1] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:1];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:1];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"3"]) {
        pageViews_m3[2] = pageViews_m3[2] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:2];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:2];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"4"]) {
        pageViews_m3[3] = pageViews_m3[3] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:3];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:3];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"5"]) {
        pageViews_m3[4] = pageViews_m3[4] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:4];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:4];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"6"]) {
        pageViews_m3[5] = pageViews_m3[5] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:5];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:5];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"7"]) {
        pageViews_m3[6] = pageViews_m3[6] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:6];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:6];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"8"]) {
        pageViews_m3[7] = pageViews_m3[7] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:7];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:7];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"9"]) {
        pageViews_m3[8] = pageViews_m3[8] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:8];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:8];
        [self startTimer];
    } if([pageLabel.text isEqualToString:@"10"]) {
        pageViews_m3[9] = pageViews_m3[9] + 1;
        NSNumber *currentTime = [self cancelTimer];
        NSNumber *oldTime = [timePerPage_m3 objectAtIndex:9];
        NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
        [timePerPage_m3 insertObject:newTime atIndex:9];
        [self startTimer];
    }

    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if ([pageLabel.text isEqualToString:@"10"] || [pageLabel.text isEqualToString:@"11"]) {
            [self performSelector:@selector(quizDelay) withObject:nil afterDelay:.5];
        }
        
        if (imageIndex_m3<[images_m3 count]-1) {
            imageIndex_m3++;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",imageIndex_m3+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images_m3 objectAtIndex:imageIndex_m3]];
        }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (imageIndex_m3>0) {
            imageIndex_m3--;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",imageIndex_m3+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromLeft]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images_m3 objectAtIndex:imageIndex_m3]];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginModule:(id)sender {
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [image addGestureRecognizer:swipeLeft];
    [image addGestureRecognizer:swipeRight];
    
    image.image = [UIImage imageNamed:[images_m3 objectAtIndex:imageIndex_m3]];
    beginModuleButton.hidden = YES;
    pageLabel.text = [NSString stringWithFormat:@"%i",imageIndex_m3+1];
    [self startTimer];
}

- (IBAction)continueToQuiz:(id)sender {
    
    pageViews_m3[10] = pageViews_m3[10] + 1;
    NSNumber *currentTime = [self cancelTimer];
    NSNumber *oldTime = [timePerPage_m3 objectAtIndex:10];
    NSNumber *newTime = [NSNumber numberWithFloat:([currentTime floatValue] + [oldTime floatValue])];
    [timePerPage_m3 insertObject:newTime atIndex:10];
    
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    for (int i = 0; i < 11; i++) {
        NSLog(@"Visited page %i %i times and spent %@ seconds  there.",i+1,pageViews_m3[i],[timePerPage_m3 objectAtIndex:i]);
    }
    
    NSLog(@"Total time for Module 3: %f",total_m3);

    [self performSegueWithIdentifier: @"toQuiz3" sender: self];
}

-(void)quizDelay {
    continueToQuizButton.hidden = NO;
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
