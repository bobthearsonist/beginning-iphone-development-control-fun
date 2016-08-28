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
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@" Are You Sure?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@" Yes, I'm sure!" style:UIAlertActionStyleDestructive handler: ^( UIAlertAction *action)
                                {
                                    NSString *msg;
                                    if ([ self.nameField.text length] > 0)
                                    {
                                        msg = [NSString stringWithFormat: @" You can breathe easy, %@, everything went OK.", self.nameField.text];
                                    }
                                    else
                                    {
                                        msg = @" You can breathe easy, everything went OK.";
                                    }
                                    UIAlertController *controller2 = [UIAlertController alertControllerWithTitle:@" Something Was Done" message:msg preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@" Phew!" style: UIAlertActionStyleCancel handler:nil];
                                    [controller2 addAction:cancelAction];
                                    [self presentViewController:controller2 animated:YES completion:nil];
                                }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@" No way!" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:yesAction];
    [controller addAction:noAction];
    UIPopoverPresentationController *ppc = controller.popoverPresentationController;
    if (ppc != nil)
    {
        ppc.sourceView = sender; ppc.sourceRect = sender.bounds;
    }
    [self presentViewController:controller animated:YES completion:nil];
}


@end
