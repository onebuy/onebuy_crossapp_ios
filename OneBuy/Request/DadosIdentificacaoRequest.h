//
//  DadosIdentificacaoRequest.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 25/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DadosIdentificacaoRequest : NSObject
@property (retain, readonly) NSString *IdentificadorUsuario;
@property (retain, readonly) NSString *PlataformaOrigem;

- (id)init;
@end
