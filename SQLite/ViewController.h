//
//  ViewController.h
//  SQLite
//
//  Created by space on 15/3/24.
//  Copyright (c) 2015年 ZYahurey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *findByRegisterNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *departmentTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *regNoTextField;
@property (weak, nonatomic) IBOutlet UITextField *old_name;
@property (weak, nonatomic) IBOutlet UITextField *ne_name;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
- (IBAction)findDate:(id)sender;

- (IBAction)saveDate:(id)sender;
- (IBAction)change:(id)sender;

@end

