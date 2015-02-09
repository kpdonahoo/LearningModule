//
//  Test.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/8/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "Test.h"

@interface Test ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *aButton;
@property (weak, nonatomic) IBOutlet UIButton *bButton;
@property (weak, nonatomic) IBOutlet UIButton *cButton;
@property (weak, nonatomic) IBOutlet UIButton *continueButton;
@property (weak, nonatomic) IBOutlet UIButton *toTest;
@property (weak, nonatomic) IBOutlet UIButton *dButton;
@property (weak, nonatomic) IBOutlet UIButton *eButton;
@property (weak, nonatomic) IBOutlet UIButton *fButton;

@end

@implementation Test
NSArray *answers;
NSArray *questions;
NSMutableArray *userAnswers;
int questions_index;
int correct = 0;
@synthesize image;
@synthesize aButton;
@synthesize bButton;
@synthesize cButton;
@synthesize dButton;
@synthesize eButton;
@synthesize fButton;
@synthesize continueButton;
@synthesize toTest;
@synthesize scoreLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userAnswers = [[NSMutableArray alloc] init];
    
    questions_index = 0;
    
    answers = @[@"a",@"d",@"e",@"b",@"f",@"b",@"d",@"c",@"c",@"d",@"b",@"a",@"c",@"a",@"b",@"c"];
    questions = @[@"Q1.png",@"Q2.png",@"Q3.png",@"Q4.png",@"Q5.png",@"Q6.png",@"Q7.png",@"Q8.png",@"Q9.png",@"Q10.png",@"Q11.png",@"Q12.png",@"Q13.png",@"Q14.png",@"Q15.png",@"Q16.png"];
    
    image.image = [UIImage imageNamed:[questions objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)aClicked:(id)sender {
    [userAnswers addObject:@"a"];
    NSLog(@"%@",userAnswers);
    [self continueTest];
}

- (IBAction)bClicked:(id)sender {
    [userAnswers addObject:@"b"];
    NSLog(@"%@",userAnswers);
    [self continueTest];
}

- (IBAction)cClicked:(id)sender {
    [userAnswers addObject:@"c"];
    NSLog(@"%@",userAnswers);
    [self continueTest];
}

- (IBAction)dClicked:(id)sender {
    [userAnswers addObject:@"d"];
    NSLog(@"%@",userAnswers);
    [self continueTest];
}

- (IBAction)eClicked:(id)sender {
    [userAnswers addObject:@"e"];
    NSLog(@"%@",userAnswers);
    [self continueTest];
}

- (IBAction)fClicked:(id)sender {
    [userAnswers addObject:@"f"];
    NSLog(@"%@",userAnswers);
    [self continueTest];
}

-(void) continueTest {
    if(questions_index <=14) {
        questions_index++;
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:[questions objectAtIndex:questions_index]];
        
        if(questions_index == 1) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q2) withObject:nil afterDelay:.5];
        } else if (questions_index == 2) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q3) withObject:nil afterDelay:.5];
        } else if (questions_index ==3) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q4) withObject:nil afterDelay:.5];
        } else if (questions_index == 4) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q5) withObject:nil afterDelay:.5];
        } else if (questions_index == 5) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q6) withObject:nil afterDelay:.5];
        } else if (questions_index == 6) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q7) withObject:nil afterDelay:.5];
        } else if (questions_index == 7) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q8) withObject:nil afterDelay:.5];
        } else if (questions_index == 8) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q9) withObject:nil afterDelay:.5];
        } else if (questions_index == 9) {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            [self performSelector:@selector(Q10) withObject:nil afterDelay:.5];
        } else {
            aButton.hidden = YES;
            bButton.hidden = YES;
            cButton.hidden = YES;
            dButton.hidden = YES;
            eButton.hidden = YES;
            fButton.hidden = YES;
            aButton.imageView.image = [UIImage imageNamed:@"negativeButton.png"];
            bButton.imageView.image = [UIImage imageNamed:@"positiveButton.png"];
            cButton.imageView.image = [UIImage imageNamed:@"invasiveButton.png"];
            [self performSelector:@selector(rest) withObject:nil afterDelay:.5];
        }
        
    } else {
        
        for (int counter = 0; counter < [answers count]; counter++) {
            if([[answers objectAtIndex:counter] isEqualToString:[userAnswers objectAtIndex:counter]]) {
                correct++;
            }
        }
        
        int score = correct/[answers count];
        
        scoreLabel.text = [NSString stringWithFormat:@"%i",score];
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5]; //Animate for a duration of 1.0 seconds
        [animation setType:kCATransitionPush]; //New image will push the old image off
        [animation setSubtype:kCATransitionFromRight]; //Current image will slide off to the left, new image slides in from the right
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [[self.image layer] addAnimation:animation forKey:nil];
        
        image.image = [UIImage imageNamed:@"ModuleCompleted.png"];
        aButton.hidden = YES;
        bButton.hidden = YES;
        cButton.hidden = YES;
        dButton.hidden = YES;
        
    }

    
}

-(void) Q2 {
    aButton.frame = CGRectMake(700,387,187,93);
    bButton.frame = CGRectMake(826,460,187,93);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q3 {
    aButton.frame = CGRectMake(782,368,91,57);
    bButton.frame = CGRectMake(844,420,91,57);
    cButton.frame = CGRectMake(845,490,91,57);
    dButton.frame = CGRectMake(223,560,91,57);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = NO;
    fButton.hidden = NO;
    eButton.frame = CGRectMake(223,610,91,57);
    fButton.frame = CGRectMake(239,660,91,57);
}

-(void) Q4 {
    aButton.frame = CGRectMake(448,387,146,89);
    bButton.frame = CGRectMake(446,462,146,89);
    cButton.frame = CGRectMake(467,535,146,89);
    dButton.frame = CGRectMake(467,611,146,89);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = YES;
    fButton.hidden = YES;
}

-(void) Q5 {
    aButton.frame = CGRectMake(382,362,119,73);
    bButton.frame = CGRectMake(307,420,119,73);
    cButton.frame = CGRectMake(452,472,119,73);
    dButton.frame = CGRectMake(869,528,119,73);
    eButton.frame = CGRectMake(288,610,119,73);
    fButton.frame = CGRectMake(251,663,119,73);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = NO;
    fButton.hidden = NO;
}

-(void) Q6 {
    aButton.frame = CGRectMake(837,393,131,72);
    bButton.frame = CGRectMake(755,469,131,72);
    cButton.frame = CGRectMake(672,542,131,72);
    dButton.frame = CGRectMake(830,617,131,72);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
    eButton.hidden = YES;
    fButton.hidden = YES;
}

-(void) Q7 {
    aButton.frame = CGRectMake(837,396,134,70);
    bButton.frame = CGRectMake(821,470,134,70);
    cButton.frame = CGRectMake(577,546,134,70);
    dButton.frame = CGRectMake(669,612,134,70);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q8 {
    aButton.frame = CGRectMake(820,384,143,88);
    bButton.frame = CGRectMake(737,461,143,88);
    cButton.frame = CGRectMake(821,538,143,88);
    dButton.frame = CGRectMake(742,602,143,88);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q9 {
    aButton.frame = CGRectMake(165,392,187,93);
    bButton.frame = CGRectMake(165,462,187,93);
    cButton.frame = CGRectMake(165,536,187,93);
    dButton.frame = CGRectMake(165,608,187,93);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) Q10 {
    aButton.frame = CGRectMake(799,404,146,78);
    bButton.frame = CGRectMake(831,476,146,78);
    cButton.frame = CGRectMake(709,567,146,78);
    dButton.frame = CGRectMake(816,626,146,78);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
    dButton.hidden = NO;
}

-(void) rest {
    aButton.frame = CGRectMake(247,642,187,93);
    bButton.frame = CGRectMake(419,649,187,93);
    cButton.frame = CGRectMake(610,649,272,93);
    aButton.hidden = NO;
    bButton.hidden = NO;
    cButton.hidden = NO;
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
