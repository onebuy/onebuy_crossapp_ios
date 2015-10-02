//
//  CapturaPedidoCrossAppRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 26/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneBuy.h"
#import "CapturaPedidoResponse.h"

@interface CapturaPedidoCrossAppRequest : NSObject

@property (retain, readonly) NSString *CodigoTransacaoGateway;
@property (retain, readonly) NSString *CodigoAutorizacao;
@property long long  ValorPedido;
@property (retain, readonly) NSString *IdentificadorUsuarioTransacao;

- (void)capturarPedido:(NSString *) codigoTransacaoGateway pedidoValor: (long long) valorPedido completo:(void (^)(CapturaPedidoResponse *objCapturaPedidoResponse))block;

@end
