//
//  RetornoResponse.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 21/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "RetornoResponse.h"

@implementation RetornoResponse
#pragma mark Métodos Públicos
- (id)init
{
    self = [super init];
    if(self) {
        _Sucesso = NO;
        _Mensagem = [[NSMutableArray alloc] init];
    }
    
    return self;
}


#pragma mark Métodos Privados

@end
