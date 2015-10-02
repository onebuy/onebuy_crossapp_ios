//
//  DadosPedidoRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DadosPedidoRequest : NSObject
@property (retain) NSString *FormaPagamento;
@property (retain, readonly) NSString *NumeroCheckout;
@property (retain) NSString *NumeroParcelas;
@property (retain) NSString *NumeroPedidoLoja;
@property long long Valor;
@property long long ValorFrete;
@property (retain) NSArray *PedidoItens;

- (id)init;
@end
