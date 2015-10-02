//
//  Cartao.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 24/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Criptografia.h"

@interface Cartao : NSObject
@property (retain) NSString *Bandeira;
@property (retain) NSString *NumeroCartaoMascarado;

- (void)descriptografar:(NSString *) chaveCriptografia;
@end
