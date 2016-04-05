//
//  OneBuy.h
//  OneBuy
//
//  Created by Andre Luiz Costa on 17/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RetornoResponse.h"
#import "CheckoutOneBuyDadosResponse.h"
#import "PedidoResponse.h"
#import "PedidoRequest.h"
#import "CapturaPedidoResponse.h"
#import "SondaPedidoResponse.h"
#import "Criptografia.h"
#import "AESCrypt.h"

#define URL_APP_STORE_ONEBUY @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=694816266&mt=8"
#define CULTURA_INTERNACIONALIZACAO @"pt-BR"
#define URL_APLICACAO_ONEBUY @"onebuy://"
#define INTEGRACAO_ONEBUY @"https://d-api.onebuy.com/hub/v1/"

typedef enum
{
    ObterToken,
    AutorizarPedido
}TipoOperacaoAppOneBuy;

@interface OneBuy : NSObject

@property (retain) NSString *chaveLoja;
@property (retain) NSString *cultura;
@property (retain) NSString *codigoAutorizacaoServidor;
@property (retain) NSString *codigoAutorizacaoCliente;
@property (retain) NSString *identificadorUsuarioTransacao;
@property (retain) NSString *numeroTransacaoCheckout;

+ (OneBuy *)sharedInstance;
- (void)abrirAppOneBuy:(TipoOperacaoAppOneBuy)objTipoOperacaoAppOneBuy comURLRetorno: (NSString *) urlRetorno completo:(void (^)(RetornoResponse *objRetornoResponse)) block;

- (void)realizarCheckOut:(NSString *) tokenOneBuyCriptografado completo:(void (^)(CheckoutOneBuyDadosResponse *objCheckoutOneBuyDadosResponse)) block;

- (void)criarPedido:(PedidoRequest *) objPedidoRequest completo:(void (^)(PedidoResponse *objPedidoResponse)) block;
- (void)capturarPedido:(NSString *) codigoTransacaoGateway pedidoValor: (long long) valorPedido completo:(void (^)(CapturaPedidoResponse *objCapturaPedidoResponse)) block;
- (void)sondarPedido:(NSString *) codigoTransacaoGateway completo:(void (^)(SondaPedidoResponse *objSondaPedidoResponse)) block;
@end
