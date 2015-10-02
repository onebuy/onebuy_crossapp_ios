//
//  CheckoutOneBuyDadosResponse.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DadosUsuarioCheckout.h"
#import "RetornoResponse.h"

@interface CheckoutOneBuyDadosResponse : NSObject

- (id)initWithJson:(id)jsonRecebido;
- (void)descriptografar:(NSString *) chaveCriptografia;

@property (retain) DadosUsuarioCheckout *DadosUsuarioCheckout;
@property (retain) RetornoResponse *RetornoResponse;
@end
