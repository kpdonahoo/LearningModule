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
@synthesize image;
@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize continueButton;
@synthesize toTest;

NSArray *answers_vq;
NSArray *questions_vq;
NSArray *correct_vq;
NSArray *incorrect_vq;
int questionsIndex_vq;
NSMutableArray *timePerQuizPage_vq;
NSNumber *sum_vq;
NSTimer *transitionTimer_vq;
NSDate* startDate_vq;
NSMutableArray *answersToQuiz_vq;

- (NSNumber*)cancelTimer {
    NSTimeInterval elapsedTime = [[NSDate date] timeIntervalSinceDate:startDate_vq];
    NSNumber *currentTime = [NSNumber numberWithDouble:elapsedTime];
    [transitionTimer_vq invalidate];
    return currentTime;
}

- (void)startTimer {
    startDate_vq = [NSDate date];
    [self startTimerMethod];
}

- (void) startTimerMethod {
    transitionTimer_vq = [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:nil userInfo:nil repeats:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    questionsIndex_vq = 0;
    
    timePerQuizPage_vq = [[NSMutableArray alloc] init];
    
    answersToQuiz_vq = [[NSMutableArray alloc] init];
    
    [self startTimer];
    
    answers_vq = @[@"a",@"c",@"b",@"a",@"a",@"c",@"b",@"c",@"b"];
    questions_vq = @[@"neg1.png",@"inv1.png",@"pos1.png",@"neg2.png",@"neg3.png",@"inv3.png",@"pos2.png",@"inv2.png",@"pos3.png"];
    incorrect_vq = @[@"neg1I.png",@"inv1I.png",@"pos1I.png",@"neg2I.png",@"neg3I.png",@"inv3I.png",@"pos2I.png",@"inv2I.png",@"pos3I.png"];
    correct_vq = @[@"neg1C.png",@"inv1C.png",@"pos1C.png",@"neg2C.png",@"neg3C.png",@"inv3C.png",@"pos2C.png",@"inv2C.png",@"pos3C.png"];
    
    image.image = [UIImage imageNamed:[questions_vq objectAtIndex:0]];
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
    
    
    NSNumber *currentTime = [self cancelTimer];
    [timePerQuizPage_vq addObject:currentTime];
    [self startTimer];
    
    aButton.hidden = YES;
    bButton.hidden = YES;
    cButton.hidden = YES;
    
    if ([answer isEqualToString:[answers_vq objectAtIndex:questionsIndex_vq]]) {
        [answersToQuiz_vq addObject:@"correct_vq"];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[correct_vq objectAtIndex:questionsIndex_vq]];
        
    } else {
        [answersToQuiz_vq addObject:@"incorrect_vq"];
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        [[continueButton layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[incorrect_vq objectAtIndex:questionsIndex_vq]];
    }
    
    continueButton.hidden = NO;
    
}

- (IBAction)continueButtonClicked:(id)sender {
    
    if (questionsIndex_vq < 8) {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_vq addObject:currentTime];
        [self startTimer];
    } else {
        NSNumber *currentTime = [self cancelTimer];
        [timePerQuizPage_vq addObject:currentTime];
    }
    
    if(questionsIndex_vq <=7) {
        questionsIndex_vq++;
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[questions_vq objectAtIndex:questionsIndex_vq]];
        
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
    /*SEND TO SERVER HERE*/
    NSLog(@"SENDING TO SERVER:");
    
    for (int counter = 0; counter < 9; counter++) {
        NSLog(@"Question %i: %@",counter+1,[answersToQuiz_vq objectAtIndex:counter]);
    }
    
    for (int i = 0; i < 18; i++) {
        NSLog(@"Spent %@ seconds on %i.",[timePerQuizPage_vq objectAtIndex:i],i+1);
        NSNumber *currentTotal = [timePerQuizPage_vq objectAtIndex:i];
        sum_vq = [NSNumber numberWithFloat:([sum_vq floatValue] + [currentTotal floatValue])];
    }
    NSLog(@"Total time for Video Quiz: %@",sum_vq);
    
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
