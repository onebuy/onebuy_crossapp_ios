//
//  Transacao.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Criptografia.h"

@interface Transacao : NSObject
@property (retain) NSString *DataFinal;
@property (retain) NSString *DataInicial;
@property (retain) NSString *NumeroTransacao;

- (void)descriptografar:(NSString *) chaveCriptografia;
@end
