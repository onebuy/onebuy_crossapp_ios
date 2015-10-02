//
//  PedidoRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DadosPedidoRequest.h"
#import "DadosAntiFraudeRequest.h"
#import "DadosIdentificacaoRequest.h"
#import "PedidoResponse.h"

@interface PedidoRequest : NSObject
@property (retain, readonly) NSString *CodigoAutorizacao;
@property (retain) DadosPedidoRequest *DadosPedido;
@property (retain) DadosAntiFraudeRequest *DadosAntiFraude;

- (id)init;
- (void)criarPedido:(PedidoRequest *) objPedidoRequest completo:(void (^)(PedidoResponse *objPedidoResponse))block;
@end
