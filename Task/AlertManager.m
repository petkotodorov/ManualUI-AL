//
//  AlertManager.m
//  Task
//
//  Created by Petko Todorov on 9/12/16.
//  Copyright © 2016 Petko Todorov. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

+(void)showAlert:(NSString *)message withTitle:(NSString *)title fromViewController: (UIViewController*) fromVC {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:nil]];
    [fromVC presentViewController:alertController
                         animated:YES
                       completion:nil];
}


@end
