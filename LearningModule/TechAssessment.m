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

@end

@implementation TechAssessment
@synthesize space;
@synthesize swipe_image;
@synthesize penguin;
@synthesize toModule1;
int swipedLeft = 0;

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
    }
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight && swipedLeft == 1)  {
        swipe_image.image= [UIImage imageNamed:@"click.png"];
        penguin.hidden = NO;
    }
}
- (IBAction)penguinClicked:(id)sender {
    penguin.hidden = TRUE;
    swipe_image.frame = CGRectMake(223,195,578,440);
    swipe_image.image = [UIImage imageNamed:@"techBoxLast.png"];
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 1;
    [toModule1.layer addAnimation:animation forKey:nil];
    toModule1.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toModule1Clicked:(id)sender {
    [self performSegueWithIdentifier:@"toModule1" sender:self];
}

@end
