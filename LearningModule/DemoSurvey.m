//
//  DemoSurvey.m
//  LearningModule
//
//  Created by Amanda Doyle on 2/7/15.
//  Copyright (c) 2015 Sharkbait. All rights reserved.
//

#import "DemoSurvey.h"


@interface DemoSurvey () <UIScrollViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *agePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *digitalPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *ethnicityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *degreePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *learningPicker;
@property (weak, nonatomic) IBOutlet UITextView *onlineCourseText;
@property (weak, nonatomic) IBOutlet UITextView *learningDisability;
@property (weak, nonatomic) IBOutlet UITextView *medicalExperience;
@property (weak, nonatomic) IBOutlet UITextView *cancer;

@end

@implementation DemoSurvey
int myNumber;
@synthesize scrollView;
@synthesize genderPicker;
@synthesize agePicker;
@synthesize digitalPicker;
@synthesize ethnicityPicker;
@synthesize degreePicker;
@synthesize learningPicker;
@synthesize onlineCourseText;
@synthesize learningDisability;
@synthesize medicalExperience;
@synthesize cancer;
NSString *onlineCourse;
NSString *genderChoice;
NSString *ageChoice;
NSString *deviceChoice;
NSString *ethChoice;
NSString *degreeChoice;
NSString *learningChoice;
NSString *learning;
NSString *medical;
NSString *cancerText;
NSArray *genderOptions;
NSArray *ageOptions;
NSArray *deviceOptions;
NSArray *degreeOptions;
NSArray *ethnicityOptions;
NSArray *learningOptions;


- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(1024, 2422);
    genderOptions = @[@"Male",@"Female",@"Other"];
    ageOptions = @[@"Under 18",@"18-24 years old",@"25-34 years old",@"35-44 years old",@"45-54 years old",@"55-64 years old",@"65-74 years old",@"75 years or older"];
    deviceOptions = @[@"Never",@"Once a month",@"One to two times per week",@"One to two times per day",@"Three or more times per day"];
    degreeOptions = @[@"No schooling completed",@"Nursery school to 8th grade",@"Some high school, no diploma",@"High school graduate, diploma or the equivalent (for example: GED)",@"Some college credit, no degree",@"Trade/technical/vocational training",@"Associate degree",@"Bachelor's degree",@"Master's degree",@"Professional degree",@"Other"];
    ethnicityOptions = @[@"White",@"Hispanic or Latino",@"Black or African American",@"Native American or American Indian",@"Asian/Pacific Islander",@"Multiracial",@"Other",@"Rather Not Say"];
    learningOptions = @[@"Yes",@"No"];
    genderPicker.dataSource = self;
    genderPicker.delegate = self;
    genderPicker.tag = 0;
    agePicker.dataSource = self;
    agePicker.delegate = self;
    agePicker.tag = 1;
    digitalPicker.dataSource = self;
    digitalPicker.delegate = self;
    digitalPicker.tag = 2;
    ethnicityPicker.dataSource = self;
    ethnicityPicker.delegate = self;
    ethnicityPicker.tag = 3;
    degreePicker.dataSource = self;
    degreePicker.delegate = self;
    degreePicker.tag = 4;
    learningPicker.dataSource = self;
    learningPicker.delegate = self;
    learningPicker.tag = 5;
    onlineCourseText.tag = 0;
    learningDisability.tag = 1;
    medicalExperience.tag = 2;
    cancer.tag = 3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } else if (pickerView.tag == 2) {
        return [deviceOptions count];
    } else if (pickerView.tag == 3) {
        return [ethnicityOptions count];
    } else if (pickerView.tag == 4) {
        return [degreeOptions count];
    } else if (pickerView.tag == 5) {
        return [learningOptions count];
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
    } else if (pickerView.tag == 2) {
        return deviceOptions[row];
    } else if (pickerView.tag == 3) {
        return ethnicityOptions[row];
    } else if (pickerView.tag == 4) {
        return degreeOptions[row];
    } else if (pickerView.tag == 5) {
        return learningOptions[row];
    } else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        genderChoice = [genderOptions objectAtIndex:row];
    } else if (pickerView.tag == 1){
        ageChoice = [ageOptions objectAtIndex:row];
    } else if (pickerView.tag == 2){
        deviceChoice = [deviceOptions objectAtIndex:row];
    } else if (pickerView.tag == 3){
        ethChoice = [ethnicityOptions objectAtIndex:row];
    } else if (pickerView.tag == 4){
        degreeChoice = [degreeOptions objectAtIndex:row];
    } else if (pickerView.tag == 5){
        learningChoice = [learningOptions objectAtIndex:row];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 0) {
        onlineCourse = textView.text;
    } else if (textView.tag == 1) {
        learning = textView.text;
    } else if (textView.tag == 2) {
        medical = textView.text;
    } else if (textView.tag == 3) {
        cancerText = textView.text;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
         if (textView.tag == 3) {
             /*SEND TO SERVER HERE*/
             NSLog(@"SENDING TO SERVER:");
             NSLog(@"gender: %@",genderChoice);
             NSLog(@"age: %@",ageChoice);
             NSLog(@"device use: %@",deviceChoice);
             NSLog(@"ethnicity: %@",ethChoice);
             NSLog(@"degree: %@",degreeChoice);
             NSLog(@"learning: %@",learningChoice);
             NSLog(@"online: %@",onlineCourse);
             NSLog(@"learning: %@",learning);
             NSLog(@"medical: %@",medical);
             NSLog(@"cancer: %@",cancerText);
              [self performSegueWithIdentifier:@"toTech" sender:self];
         } else {
             [textView resignFirstResponder];
             return NO;
         }
    }
    
    return YES;
}

@end
