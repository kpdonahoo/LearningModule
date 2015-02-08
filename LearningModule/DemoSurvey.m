//
//  DemoSurvey.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "DemoSurvey.h"


@interface DemoSurvey () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DemoSurvey
int myNumber;
@synthesize beginButton;
@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StartDemoSurvey:(id)sender {
    myNumber = arc4random()%899 + 100;
    NSLog(@"%i",myNumber);
    beginButton.hidden = YES;
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
