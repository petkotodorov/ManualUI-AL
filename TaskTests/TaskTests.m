//
//  TaskTests.m
//  TaskTests
//
//  Created by Petko Todorov on 9/12/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArticlesTableViewController.h"

@interface TaskTests : XCTestCase

@end

@implementation TaskTests

ArticlesTableViewController *articlesController;

- (void)setUp {
    [super setUp];
    articlesController = [[ArticlesTableViewController alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
