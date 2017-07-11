# STPickerView

![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)
![Pod version](https://img.shields.io/cocoapods/v/STPickerView.svg?style=flat)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform info](https://img.shields.io/cocoapods/p/STPickerView.svg?style=flat)](http://cocoadocs.org/docsets/STPickerView)

一个多功能的选择器,有城市选择，日期选择和单数组源自定的功能，方便大家的使用,低耦合,易扩展。如果大家喜欢请给个星星，我将不断提供更好的代码。

----------------------------

## 一、使用

1. 使用POD方式 `pod 'STPickerView', '2.2'`
2. 使用carthage方式 `github "STShenzhaoliang/STPickerView" "2.2"` 

## 二、效果图展示
### 1.城市选择器效果图
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/show0.gif)
### 2.日期选择器效果图
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/show2.gif)
### 3.单数组效果图
#### 根据单数据的模式，可以扩展多数据的模式
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/show1.gif)

### 4.中间的显示模式
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/show4.png)

## 三、接口
### 1.显示模式枚举
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/picture0.jpg)
### 2.视图接口
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/picture1.jpg)
### 3.方法接口
![image](https://github.com/STShenZhaoliang/STImage/blob/master/STPickerView/picture2.jpg)

## 四、使用举例

```

STPickerSingle *pickerSingle = [[STPickerSingle alloc]init];
[pickerSingle setArrayData:arrayData];
[pickerSingle setTitle:@"请选择价格"];
[pickerSingle setTitleUnit:@"人民币"];
[pickerSingle setContentMode:STPickerContentModeCenter];
[pickerSingle setDelegate:self];
[pickerSingle show];

```

