//
//  Intro.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/8/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Intro.h"

@interface Intro ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *beginButton;

@end

@implementation Intro
@synthesize image;
@synthesize beginButton;
NSArray *images;
int image_index;

- (void)viewDidLoad {
    [super viewDidLoad];
    image_index = 0;
    images = @[@"Intro1",@"Intro2.png",@"Intro3.png"];

UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];

// Setting the swipe direction.
[swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
[swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];

// Adding the swipe gesture on image view
[image addGestureRecognizer:swipeLeft];
[image addGestureRecognizer:swipeRight];
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if (image_index<[images count]-1) {
            image_index++;
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
            
        }
        
        if (image_index==[images count]-1) {
            
            CATransition *animation = [CATransition animation];
            animation.type = kCATransitionFade;
            animation.duration = 1;
            [beginButton.layer addAnimation:animation forKey:nil];
            beginButton.hidden = NO;
            
        }

    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (image_index>0) {
            image_index--;
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromLeft]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
        }
    }
    
}


- (IBAction)beginClicked:(id)sender {
    /*MAKE THE CALL TO SERVER TO GET THE PARTICIPANT ID*/
    [self performSegueWithIdentifier:@"toDemoSurvey" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
