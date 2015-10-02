//
//  PedidoResponse.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetornoResponse.h"

@interface PedidoResponse : NSObject

- (id)initWithJson:(id)jsonRecebido;

@property (retain) NSString *CodigoTransacaoGateway;
@property (retain) NSString *CodigoTransacaoAdquirente;
@property long Valor;
@property (retain) NSString *CodigoAutorizacao;
@property (retain) NSString *BandeiraCartao;
@property (retain) NSString *NumeroCartaoMascarado;
@property (retain) RetornoResponse *RetornoResponse;
@end
