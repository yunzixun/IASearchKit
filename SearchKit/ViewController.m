//
//  ViewController.m
//  SearchKit
//
//  Created by Alter on 2018/7/15.
//  Copyright © 2018年 Netease. All rights reserved.
//



#import "ViewController.h"
#import "NSString+Search.h"
#import "IAPinYinHelper.h"
#import "IAPinYinManager.h"
#import "NSArray+Combine.h"

@interface ViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    // 请在合适的时候加载文件
    [[IAPinYinManager shared] loadPinyinData];
    
    
    
    // 测试链
    [self testPinyinsearch];
}

- (void)testGetRanges {
    // 测试高亮
}

- (void)testKeywordSearch {
    NSArray *arr = [IAPinYinHelper toPinyinWithString:@"重庆乐否"];
    NSLog(@"%@",arr);
}

- (NSArray *)testArrCombine {
    NSArray *arr = [@[@[@"1",@"2"],@[@"3"],@[@"4",@"5",@"6"],@[@"7",@"8"]] combine];
    return arr;
}

- (NSArray *)testArrCombine2 {
    NSArray *arr = [@[@[@"1",@"2"],@[@"3"],@[@"4",@"5",@"6"],@[@"7",@"8"]] combine2];
    return arr;
}

- (void)timelost {
    CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
//    [self testArrCombine];
    [self testArrCombine2];
    CFAbsoluteTime end = CFAbsoluteTimeGetCurrent() - start;
    NSLog(@"1 -- %lf",end);
}

- (void)testPinyinsearch {
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    NSRange range;
//    BOOL match = [self.textLabel.text canMatchWithKeyword:searchText range:&range];
    NSArray *ranges;
    BOOL match = [self.textLabel.text canMatchWithKeyword:searchText allRanges:&ranges];
    if (match) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.textLabel.text];
        for (NSValue *rv in ranges) {
            [att addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:rv.rangeValue];
        }
        self.textLabel.attributedText = [att copy];
    } else {
        self.textLabel.attributedText = [[NSAttributedString alloc] initWithString:self.textLabel.text];
    }
}

@end
