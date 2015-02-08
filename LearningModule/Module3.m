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
NSArray *images;
int image_index;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [image setUserInteractionEnabled:YES];
    
    UIFont *font = [UIFont fontWithName:@"PTSans-Regular" size:18];
    pageLabel.font = font;
    image_index = 0;
    
    images = @[@"Module3-1.png",@"Module3-2.png",@"Module3-3.png",@"Module3-4.png",@"Module3-5.png",@"Module3-6.png",@"Module3-7.png",@"Module3-8.png",@"Module3-9.png",@"Module3-10.png",@"Module3-11.png"];
    
    
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
    
    continueToQuizButton.hidden = YES;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        if ([pageLabel.text isEqualToString:@"10"] || [pageLabel.text isEqualToString:@"11"]) {
            [self performSelector:@selector(quizDelay) withObject:nil afterDelay:.5];
        }
        
        if (image_index<[images count]-1) {
            image_index++;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",image_index+1];
            
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
            [animation setType:kCATransitionPush]; //New image will push the old image off
            [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            [[self.image layer] addAnimation:animation forKey:nil];
            
            image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
        }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        if (image_index>0) {
            image_index--;
            
            pageLabel.text = [NSString stringWithFormat:@"%i",image_index+1];
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginModule:(id)sender {
    image.image = [UIImage imageNamed:[images objectAtIndex:image_index]];
    beginModuleButton.hidden = YES;
    pageLabel.text = [NSString stringWithFormat:@"%i",image_index+1];
}

- (IBAction)continueToQuiz:(id)sender {
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
