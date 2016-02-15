//
//  ViewController.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "ViewController.h"

#import "STPickerArea.h"
@interface ViewController ()<UITextFieldDelegate, STPickerAreaDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textArea;
@end

@implementation ViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textArea.delegate = self;
    
}


#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.textArea resignFirstResponder];

    STPickerArea  *pickerArea = [[STPickerArea alloc]init];
    [pickerArea setDelegate:self];
    [pickerArea show];
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.textArea.text = text;
}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---

@end
