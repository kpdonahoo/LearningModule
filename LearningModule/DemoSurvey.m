//
//  DemoSurvey.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "DemoSurvey.h"


@interface DemoSurvey () <UIScrollViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *agePicker;

@end

@implementation DemoSurvey
int myNumber;
@synthesize beginButton;
@synthesize scrollView;
@synthesize backgroundImage;
@synthesize genderPicker;
@synthesize agePicker;
NSArray *genderOptions;
NSArray *ageOptions;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(1024, 1500);
    genderOptions = @[@"Male",@"Female",@"Other"];
    ageOptions = @[@"Under 18",@"18-24 years old",@"25-34 years old",@"35-44 years old",@"45-54 years old",@"55-64 years old",@"65-74 years old",@"75 years or older"];
    genderPicker.dataSource = self;
    genderPicker.delegate = self;
    genderPicker.tag = 0;
    agePicker.dataSource = self;
    agePicker.delegate = self;
    agePicker.tag = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StartDemoSurvey:(id)sender {
    myNumber = arc4random()%899 + 100;
    NSLog(@"%i",myNumber);
    beginButton.hidden = YES;
    scrollView.hidden = NO;
    backgroundImage.hidden = YES;
    genderPicker.hidden = NO;
    agePicker.hidden = NO;
}

- (long)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (long)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        return [genderOptions count];
    } else if (pickerView.tag == 1) {
        return [ageOptions count];
    } else {
        return 0;
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        return genderOptions[row];
    } else if (pickerView.tag == 1) {
        return ageOptions[row];
    } else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        NSString *genderChoice = [genderOptions objectAtIndex:row];
        NSLog(@"gender: %@",genderChoice);
    } else {
        NSString *ageChoice = [ageOptions objectAtIndex:row];
        NSLog(@"age: %@",ageChoice);
    }
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
