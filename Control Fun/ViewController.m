//
//  ViewController.m
//  Control Fun
//
//  Created by admin on 8/27/16.
//  Copyright © 2016 Apress. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;
@property (weak, nonatomic) IBOutlet UIButton *doSomethingButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *toggleControls;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sliderLabel.text = @"50";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    //clsoe the keyboard if the background is touched
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

- (IBAction)sliderChanged:(UISlider*)sender {
    int progress = (int)lroundf(sender.value);
    self.sliderLabel.text = [NSString stringWithFormat:@"%d", progress];
}

- (IBAction)switchChanged:(UISwitch*)sender{
    
    BOOL setting = sender.isOn;
    
    [self.leftSwitch setOn:setting animated:YES];
    [self.rightSwitch setOn:setting animated:YES];
}

- (IBAction)toggleControls:(UISegmentedControl *)sender {
    self.leftSwitch.hidden ^= YES;
    self.rightSwitch.hidden ^= YES;
    self.doSomethingButton.hidden ^= YES;
}

- (IBAction)buttonPressed:(UIButton *)sender {
    UIAlertController* areYouSureController = [UIAlertController alertControllerWithTitle:@"Are you sure?" message: nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* yesIAmSureAction = [UIAlertAction actionWithTitle:@"Yes, I'm sure!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action)
                                       {
                                           NSString* yesIamSureMessage = [NSString stringWithFormat:@"You can breathe easy, %@everything went okay", [self.nameField.text length] ?[NSString stringWithFormat:@"%@, ",self.nameField.text]:@""];
                                           
                                           UIAlertController* yesImSureConfirmationController = [UIAlertController alertControllerWithTitle:@"Something Was Done" message:yesIamSureMessage preferredStyle:UIAlertControllerStyleAlert];
                                           [yesImSureConfirmationController addAction:[UIAlertAction actionWithTitle:@"Phew!" style:UIAlertActionStyleCancel handler:nil]];
                                           
                                           [self presentViewController:yesImSureConfirmationController animated:NO completion:nil];
                                       }];
    [areYouSureController addAction:yesIAmSureAction];
    
    UIAlertAction* noIamNotSureAction = [UIAlertAction actionWithTitle:@"No way!" style:UIAlertActionStyleCancel handler:nil];
    [areYouSureController addAction:noIamNotSureAction];
    
    UIPopoverPresentationController *popoverController = areYouSureController.popoverPresentationController;
    
    if (popoverController)
    {
        popoverController.sourceView = sender;
        popoverController.sourceRect = sender.bounds;
        popoverController.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    
    [self presentViewController:areYouSureController animated:YES completion:nil];
}


@end
