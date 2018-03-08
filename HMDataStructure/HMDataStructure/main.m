//
//  main.m
//  GraphAgthm
//
//  Created by 万能的仓鼠 on 5/24/16.
//  Copyright © 2016 UryuoHamusta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMDataStructure.h"//定义实现分离
@interface <#class name#> : NSMutableArray

@end
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //注意 使用时请手动设置path
        NSLog(@"1");
        HMGraph *graph=[[HMGraph alloc]initStringObjectWithPath: @"/Users/UryuoHamusta/Desktop/ginput3.txt"];
        NSArray* dtsk= [graph deepFirstSearch];
        NSArray* bfsk=[graph breadthFirstSearch];
        NSLog(@"%@",dtsk);
        NSLog(@"%@",bfsk);
        NSLog(@"%@",[graph isGraphInterConnected]?@"Yes":@"No");
    }
    return 0;
}
