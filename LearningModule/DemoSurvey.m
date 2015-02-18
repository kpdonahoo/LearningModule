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
@property (weak, nonatomic) IBOutlet UITextView *onlineCourse_dsText;
@property (weak, nonatomic) IBOutlet UITextView *learningDisability;
@property (weak, nonatomic) IBOutlet UITextView *medical_dsExperience;
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
@synthesize onlineCourse_dsText;
@synthesize learningDisability;
@synthesize medical_dsExperience;
@synthesize cancer;
NSString *onlineCourse_ds;
NSString *genderChoice_ds;
NSString *ageChoice_ds;
NSString *deviceChoice_ds;
NSString *ethChoice_ds;
NSString *degreeChoice_ds;
NSString *learningChoice_ds;
NSString *learning_ds;
NSString *medical_ds;
NSString *cancerText_ds;
NSArray *genderOptions_ds;
NSArray *ageOptions_ds;
NSArray *deviceOptions_ds;
NSArray *degreeOptions_ds;
NSArray *ethnicityOptions_ds;
NSArray *learningOptions_ds;


- (void)viewDidLoad {
    [super viewDidLoad];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(1024, 2422);
    genderOptions_ds = @[@"Male",@"Female",@"Other"];
    ageOptions_ds = @[@"Under 18",@"18-24 years old",@"25-34 years old",@"35-44 years old",@"45-54 years old",@"55-64 years old",@"65-74 years old",@"75 years or older"];
    deviceOptions_ds = @[@"Never",@"Once a month",@"One to two times per week",@"One to two times per day",@"Three or more times per day"];
    degreeOptions_ds = @[@"No schooling completed",@"Nursery school to 8th grade",@"Some high school, no diploma",@"High school graduate, diploma or the equivalent (for example: GED)",@"Some college credit, no degree",@"Trade/technical/vocational training",@"Associate degree",@"Bachelor's degree",@"Master's degree",@"Professional degree",@"Other"];
    ethnicityOptions_ds = @[@"White",@"Hispanic or Latino",@"Black or African American",@"Native American or American Indian",@"Asian/Pacific Islander",@"Multiracial",@"Other",@"Rather Not Say"];
    learningOptions_ds = @[@"Yes",@"No"];
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
    onlineCourse_dsText.tag = 0;
    learningDisability.tag = 1;
    medical_dsExperience.tag = 2;
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
        return [genderOptions_ds count];
    } else if (pickerView.tag == 1) {
        return [ageOptions_ds count];
    } else if (pickerView.tag == 2) {
        return [deviceOptions_ds count];
    } else if (pickerView.tag == 3) {
        return [ethnicityOptions_ds count];
    } else if (pickerView.tag == 4) {
        return [degreeOptions_ds count];
    } else if (pickerView.tag == 5) {
        return [learningOptions_ds count];
    } else {
        return 0;
    }
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        return genderOptions_ds[row];
    } else if (pickerView.tag == 1) {
        return ageOptions_ds[row];
    } else if (pickerView.tag == 2) {
        return deviceOptions_ds[row];
    } else if (pickerView.tag == 3) {
        return ethnicityOptions_ds[row];
    } else if (pickerView.tag == 4) {
        return degreeOptions_ds[row];
    } else if (pickerView.tag == 5) {
        return learningOptions_ds[row];
    } else {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 0) {
        genderChoice_ds = [genderOptions_ds objectAtIndex:row];
    } else if (pickerView.tag == 1){
        ageChoice_ds = [ageOptions_ds objectAtIndex:row];
    } else if (pickerView.tag == 2){
        deviceChoice_ds = [deviceOptions_ds objectAtIndex:row];
    } else if (pickerView.tag == 3){
        ethChoice_ds = [ethnicityOptions_ds objectAtIndex:row];
    } else if (pickerView.tag == 4){
        degreeChoice_ds = [degreeOptions_ds objectAtIndex:row];
    } else if (pickerView.tag == 5){
        learningChoice_ds = [learningOptions_ds objectAtIndex:row];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.tag == 0) {
        onlineCourse_ds = textView.text;
    } else if (textView.tag == 1) {
        learning_ds = textView.text;
    } else if (textView.tag == 2) {
        medical_ds = textView.text;
    } else if (textView.tag == 3) {
        cancerText_ds = textView.text;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
         if (textView.tag == 3) {
             /*SEND TO SERVER HERE*/
             NSLog(@"SENDING TO SERVER:");
             NSLog(@"gender: %@",genderChoice_ds);
             NSLog(@"age: %@",ageChoice_ds);
             NSLog(@"device use: %@",deviceChoice_ds);
             NSLog(@"ethnicity: %@",ethChoice_ds);
             NSLog(@"degree: %@",degreeChoice_ds);
             NSLog(@"learning: %@",learningChoice_ds);
             NSLog(@"online: %@",onlineCourse_ds);
             NSLog(@"learning: %@",learning_ds);
             NSLog(@"medical_ds: %@",medical_ds);
             NSLog(@"cancer: %@",cancerText_ds);
              [self performSegueWithIdentifier:@"toTech" sender:self];
         } else {
             [textView resignFirstResponder];
             return NO;
         }
    }
    
    return YES;
}

@end
