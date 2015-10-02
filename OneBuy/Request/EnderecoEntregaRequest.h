//
//  EnderecoEntregaRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnderecoEntregaRequest : NSObject

@property int Cep;
@property (retain) NSString *Pais;
@property (retain) NSString *Estado;
@property (retain) NSString *Cidade;
@property (retain) NSString *Bairro;
@property (retain) NSString *Rua;
@property (retain) NSString *Numero;
@property (retain) NSString *Complemento;
@end
