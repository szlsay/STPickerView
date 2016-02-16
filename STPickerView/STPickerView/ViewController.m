//
//  ViewController.m
//  STPickerView
//
//  Created by https://github.com/STShenZhaoliang/STPickerView on 16/2/15.
//  Copyright © 2016年 shentian. All rights reserved.
//

#import "ViewController.h"

#import "STPickerArea.h"
#import "STPickerSingle.h"

@interface ViewController ()<UITextFieldDelegate, STPickerAreaDelegate, STPickerSingleDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textArea;
@property (weak, nonatomic) IBOutlet UITextField *textSingle;
@end

@implementation ViewController

#pragma mark - --- lift cycle 生命周期 ---
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textArea.delegate = self;
    self.textSingle.delegate = self;
    
}


#pragma mark - --- delegate 视图委托 ---

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.textArea) {
        [self.textArea resignFirstResponder];
        [[[STPickerArea alloc]initWithDelegate:self]show];
    }
    
    if (textField == self.textSingle) {
        [self.textSingle resignFirstResponder];
        
        NSMutableArray *arrayData = [NSMutableArray array];
        for (int i = 1; i < 1000; i++) {
            NSString *string = [NSString stringWithFormat:@"%d", i];
            [arrayData addObject:string];
        }
        
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:arrayData];
        [single setTitle:@"请选择价格"];
        [single setTitleUnit:@"人民币"];
        [single setDelegate:self];
        [single show];
    }
    
}

- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    self.textArea.text = text;
}

- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle
{
    NSString *text = [NSString stringWithFormat:@"%@ 人民币", selectedTitle];
    self.textSingle.text = text;
}
#pragma mark - --- event response 事件相应 ---

#pragma mark - --- private methods 私有方法 ---

#pragma mark - --- getters and setters 属性 ---

@end
