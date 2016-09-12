//
//  AlertManager.h
//  Task
//
//  Created by Petko Todorov on 9/12/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertManager : NSObject

+(void)showAlert:(NSString *)message withTitle:(NSString *)title fromViewController: (UIViewController*) fromVC;

@end
