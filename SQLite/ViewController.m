//
//  ViewController.m
//  SQLite
//
//  Created by space on 15/3/24.
//  Copyright (c) 2015年 ZYahurey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)
nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)findDate:(id)sender {
    NSArray *datas = [[DBManager getShareInsetance]findByRegisterNumber:
                     _findByRegisterNumberTextField.text];
    if (datas.count>0) {
        NSArray *data = datas[0];
        _regNoTextField.text = data[0];
        _nameTextField.text = data[1];
        _departmentTextField.text = data[2];
        _yearTextField.text = data[3];
    }else{
        _regNoTextField.text = @"";
        _nameTextField.text =@"";
        _departmentTextField.text = @"";
        _yearTextField.text =@"";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
                              @"没有数据" message:nil delegate:nil cancelButtonTitle:
                              @"OK" otherButtonTitles:nil];
        [alert show];
    }
//    BOOL success = [[DBManager getShareInsetance]delByRegisterNumber:_findByRegisterNumberTextField.text];
//    
//    if (success == NO) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
//                              @"删除失败" message:nil delegate:nil cancelButtonTitle:
//                              @"OK" otherButtonTitles:nil];
//        [alert show];
//    }
//    else{
//        _regNoTextField.text = _findByRegisterNumberTextField.text;
//        _nameTextField.text =[data objectAtIndex:0];
//        _departmentTextField.text = [data objectAtIndex:1];
//        _yearTextField.text =[data objectAtIndex:2];
//    }
}

- (IBAction)saveDate:(id)sender {
    BOOL success = NO;
    NSString *alertString = @"Data Insertion failed";
    if (_regNoTextField.text.length>0 &&_nameTextField.text.length>0 &&
        _departmentTextField.text.length>0 &&_yearTextField.text.length>0 )
    {
      success = [[DBManager getShareInsetance]saveData:
                   _regNoTextField.text name:_nameTextField.text department:
                   _departmentTextField.text year:_yearTextField.text];
    }
    else{
        alertString = @"Enter all fields";
    }
    if (!success) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
                              alertString message:nil
                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
   
}

- (IBAction)change:(id)sender {
     BOOL success = NO;
    success = [[DBManager getShareInsetance]updateByRegisterNumber:_old_name.text name:_ne_name.text];
    if (success == NO) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:
                              @"修改失败" message:nil
                                                      delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - Text field delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [_myScrollView setFrame:CGRectMake(10, 50, 300, 200)];
    [_myScrollView setContentSize:CGSizeMake(300, 350)];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [_myScrollView setFrame:CGRectMake(10, 50, 300, 350)];
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_findByRegisterNumberTextField resignFirstResponder];
    [_yearTextField resignFirstResponder];
    [_departmentTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
    [_regNoTextField resignFirstResponder];
    [_old_name resignFirstResponder];
    [_ne_name resignFirstResponder];
    [_myScrollView resignFirstResponder];
}
@end
