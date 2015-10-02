//
//  DadosPedidoRequest.m
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import "DadosPedidoRequest.h"
#import "OneBuy.h"

@implementation DadosPedidoRequest
#pragma mark Métodos Públicos
- (id)init
{
    self = [super init];
    if(self) {
        _NumeroCheckout = [[OneBuy sharedInstance] numeroTransacaoCheckout];
    }
    
    return self;
}


#pragma mark Métodos Privados
@end
