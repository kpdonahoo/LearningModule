//
//  Module1Quiz.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Module1Quiz.h"

@interface Module1Quiz () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *toModule2;
@property (weak, nonatomic) IBOutlet UIButton *continueButton2;
@property (weak, nonatomic) IBOutlet UIButton *backButton;


@end

@implementation Module1Quiz
NSArray *answers;
NSArray *questions;
NSArray *correct_answers;
NSArray *incorrect;
int questions_index;
@synthesize image;
@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize dButton;
@synthesize continueButton;
@synthesize continueButton2;
@synthesize toModule2;
UIAlertView *alert;
@synthesize backButton;
NSMutableArray *timePerQuizPage;
NSNumber *sum;
NSTimer *transitionTimer;
NSDate* startDate;
NSMutableArray *answersToQuiz;

- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate];
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer invalidate];
    return currentTime;
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
    questions_index = 0;
    
    timePerQuizPage = [[NSMutableArray alloc] init];
    
    answersToQuiz = [[NSMutableArray alloc] init];
    
    answers = @[@"b",@"a",@"a"];
    questions = @[@"Module1Q1.png",@"Module1Q2.png",@"Module1Q3.png"];
    incorrect = @[@"Module1Q1I.png",@"Module1Q2I.png",@"Module1Q3I.png"];
    correct_answers = @[@"Module1Q1C.png",@"Module1Q2C.png",@"Module1Q3C.png"];
    
    image.image = [UIImage imageNamed:[questions objectAtIndex:0]];
    [self performSelector:@selector(hideAD) withObject:nil afterDelay:.5];
    
    [self startTimer];
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

- (IBAction)dClicked:(id)sender {
    [self checkAnswer:@"d"];
}

-(void) checkAnswer:(NSString *) answer {
    
    NSNumber *currentTime = [self cancelTimer];
    [timePerQuizPage addObject:currentTime];
    [self startTimer];

    aButton.hidden = YES;
    bButton.hidden = YES;
    cButton.hidden = YES;
    dButton.hidden = YES;
    
    if ([answer isEqualToString:[answers objectAtIndex:questions_index]]) {
        [answersToQuiz addObject:@"correct"];
        [self performSelector:@selector(hideButtonTwo) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[correct_answers objectAtIndex:questions_index]];
        
    } else {
        [answersToQuiz addObject:@"incorrect"];
        [self performSelector:@selector(hideButtonOne) withObject:nil afterDelay:.5];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        [[continueButton layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[incorrect objectAtIndex:questions_index]];
    }
    
}

- (IBAction)continueButtonClicked:(id)sender {
    
    if (questions_index < 2) {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage addObject:currentTime];
        [self startTimer];
    } else {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage addObject:currentTime];
    }
    
    if(questions_index <=1) {
    questions_index++;
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
    [animation setType:kCATransitionPush]; //New image will push the old image off
    [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.image layer] addAnimation:animation forKey:nil];
    
    image.image = [UIImage imageNamed:[questions objectAtIndex:questions_index]];
        
    continueButton.Hidden = YES;
    continueButton2.Hidden = YES;
        
    
    if (questions_index > 0) {
        
        aButton.frame = CGRectMake(810, 505, 200, 95);
        [self performSelector:@selector(hideButtonA) withObject:nil afterDelay:.5];
        
        bButton.frame = CGRectMake(775, 607, 200, 95);
        aButton.imageView.image = [UIImage imageNamed:@"button.png"];
        [self performSelector:@selector(hideButtonB) withObject:nil afterDelay:.5];
    }
        
    } else {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:@"Module1Completed.png"];
        [self performSelector:@selector(hideModuleTransition) withObject:nil afterDelay:.5];
        continueButton2.hidden = YES;
        continueButton.hidden = YES;
    }
}
- (IBAction)toModule1:(id)sender {
    [self performSegueWithIdentifier:@"toModule1" sender:self];
}

- (IBAction)toModule2:(id)sender {
    alert = [[UIAlertView alloc] initWithTitle:@"Warning!" message:@"\nModule 2 contains graphic content."  delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    
    for (int counter = 0; counter < 3; counter++) {
        NSLog(@"Question %i: %@",counter+1,[answersToQuiz objectAtIndex:counter]);
    }
    
    for (int i = 0; i < 6; i++) {
        NSLog(@"Spent %@ seconds on %i.",[timePerQuizPage objectAtIndex:i],i+1);
        NSNumber *currentTotal = [timePerQuizPage objectAtIndex:i];
        sum = [NSNumber numberWithFloat:([sum floatValue] + [currentTotal floatValue])];
    }
    NSLog(@"Total time for Module 1 Quiz: %@",sum);
    
    [self performSegueWithIdentifier:@"toModule2" sender:self];
    
}


-(void) hideButtonOne {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0;
    [continueButton.layer addAnimation:animation forKey:nil];
    continueButton.hidden = NO;
}

-(void) hideButtonTwo {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0;
    [continueButton2.layer addAnimation:animation forKey:nil];
    continueButton2.hidden = NO;
}

-(void) hideButtonA {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [aButton.layer addAnimation:animation forKey:nil];
    aButton.hidden = NO;
}

-(void) hideButtonB {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [bButton.layer addAnimation:animation forKey:nil];
    bButton.hidden = NO;
}

-(void) hideModuleTransition {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [toModule2.layer addAnimation:animation forKey:nil];
    [backButton.layer addAnimation:animation forKey:nil];
    toModule2.hidden = NO;
    backButton.hidden = NO;
}
-(void) hideAD {
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [toModule2.layer addAnimation:animation forKey:nil];
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
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
