//
//  ASHEditStepViewController.m
//  C-41
//
//  Created by Ash Furrow on 12/28/2013.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "ASHEditStepViewController.h"

// View Model
#import "ASHEditStepViewModel.h"

@interface ASHEditStepViewController ()

@property (weak, nonatomic) IBOutlet UITextField *stepNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *stepDescriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *agitationFrequencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *agitationDurationLabel;
@property (weak, nonatomic) IBOutlet UIStepper *temperatureStepper;
@property (weak, nonatomic) IBOutlet UIStepper *agitationFrequencyStepper;
@property (weak, nonatomic) IBOutlet UIStepper *agitationDurationStepper;

@end

@implementation ASHEditStepViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.stepNameTextField.text = self.viewModel.stepName;
    self.stepDescriptionTextField.text = self.viewModel.stepDescription;
    
    // Reactive Bindings
    RAC(self, title) = RACObserve(self.viewModel, stepName);
    
    RAC(self.viewModel, stepName) = self.stepNameTextField.rac_textSignal;
    RAC(self.viewModel, stepDescription) = self.stepDescriptionTextField.rac_textSignal;
    
    RAC(self.temperatureLabel, text) = RACObserve(self.viewModel, temperatureString);
    RAC(self.agitationDurationLabel, text) = RACObserve(self.viewModel, agitationDurationString);
    RAC(self.agitationFrequencyLabel, text) = RACObserve(self.viewModel, agitationFrequencyString);
    
    id(^mapBlock)(UIStepper *stepper) = ^id(UIStepper *stepper){
        return @(stepper.value);
    };
    
    RAC(self.viewModel, temperatureCelcius) = [[self.temperatureStepper rac_signalForControlEvents:UIControlEventValueChanged] map:mapBlock];
    RAC(self.viewModel, agitationDuration) = [[self.agitationDurationStepper rac_signalForControlEvents:UIControlEventValueChanged] map:mapBlock];
    RAC(self.viewModel, agitationFrequency) = [[self.agitationFrequencyStepper rac_signalForControlEvents:UIControlEventValueChanged] map:mapBlock];
}

@end