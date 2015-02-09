//
//  VideoQuiz.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/8/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "VideoQuiz.h"

@interface VideoQuiz ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *toTest;
@end

@implementation VideoQuiz

NSArray *answers;
NSArray *questions;
NSArray *correct;
NSArray *incorrect;
int questions_index;
@synthesize image;
@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize continueButton;
@synthesize toTest;

- (void)viewDidLoad {
    [super viewDidLoad];
    questions_index = 0;
    
    answers = @[@"a",@"c",@"b",@"a",@"a",@"c",@"b",@"c",@"b"];
    questions = @[@"neg1.png",@"inv1.png",@"pos1.png",@"neg2.png",@"neg3.png",@"inv3.png",@"pos2.png",@"inv2.png",@"pos3.png"];
    incorrect = @[@"neg1I.png",@"inv1I.png",@"pos1I.png",@"neg2I.png",@"neg3I.png",@"inv3I.png",@"pos2I.png",@"inv2I.png",@"pos3I.png"];
    correct = @[@"neg1C.png",@"inv1C.png",@"pos1C.png",@"neg2C.png",@"neg3C.png",@"inv3C.png",@"pos2C.png",@"inv2C.png",@"pos3C.png"];
    
    image.image = [UIImage imageNamed:[questions objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aClicked:(id)sender {
    [self checkAnswer:@"a"];
}

- (IBAction)bClicked:(id)sender {
    [self checkAnswer:@"b"];
}

- (IBAction)cClicked:(id)sender {
    [self checkAnswer:@"c"];
}

-(void) checkAnswer:(NSString *) answer {
    
    aButton.hidden = YES;
    bButton.hidden = YES;
    cButton.hidden = YES;
    
    if ([answer isEqualToString:[answers objectAtIndex:questions_index]]) {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[correct objectAtIndex:questions_index]];
        
    } else {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        [[continueButton layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[incorrect objectAtIndex:questions_index]];
    }
    
    continueButton.hidden = NO;
    
}

- (IBAction)continueButtonClicked:(id)sender {
    
    if(questions_index <=7) {
        questions_index++;
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[questions objectAtIndex:questions_index]];
        
        aButton.hidden = NO;
        bButton.hidden = NO;
        cButton.hidden = NO;
        
        continueButton.Hidden = YES;
        
    } else {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:@"VideoQuizComplete.png"];
        continueButton.hidden = YES;
        
        [self performSelector:@selector(showTest) withObject:nil afterDelay:.5];
    
    }
}

- (IBAction)toTest:(id)sender {
    [self performSegueWithIdentifier:@"toTest" sender:self];
}

-(void) showTest {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [toTest.layer addAnimation:animation forKey:nil];
    toTest.hidden = NO;
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
