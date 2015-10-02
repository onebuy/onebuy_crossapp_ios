//
//  SondaPedidoResponse.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 31/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetornoResponse.h"
#import "DadosCartaoManager.h"

@interface SondaPedidoResponse : NSObject

@property (retain) RetornoResponse *RetornoResponse;
@property (retain) NSString *Status;
@property int CodigoStatus;
@property (retain) NSString *NumeroPedidoLoja;
@property (retain) NSString *CodigoTransacaoGateway;
@property (retain) NSString *CodigoAutorizacao;
@property (retain) DadosCartaoManager *DadosCartao;

- (id)initWithJson:(id)jsonRecebido;
@end
