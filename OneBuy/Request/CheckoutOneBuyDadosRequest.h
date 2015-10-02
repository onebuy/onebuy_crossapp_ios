//
//  CheckoutOneBuyDadosRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneBuy.h"
#import "CheckoutOneBuyDadosResponse.h"

@interface CheckoutOneBuyDadosRequest : NSObject


- (void)realizarCheckoutOneBuyComToken:(NSString *) tokenOneBuy completo:(void (^)(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse))block;

@end
