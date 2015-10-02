//
//  SondaPedidoRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 26/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneBuy.h"
#import "SondaPedidoResponse.h"

@interface SondaPedidoRequest : NSObject

@property (retain, readonly) NSString *CodigoTransacaoGateway;
@property (retain, readonly) NSString *CodigoAutorizacao;

- (void)sondarPedido:(NSString *) codigoTransacaoGateway completo:(void (^)(SondaPedidoResponse *objSondaPedidoResponse))block;
@end
