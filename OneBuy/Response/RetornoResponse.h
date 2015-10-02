//
//  RetornoResponse.h
//  CrossAppTeste
//
//  Created by Andre Luiz Costa on 21/08/15.
//  Copyright (c) 2015 OneBuy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RetornoResponse : NSObject
@property BOOL Sucesso;
@property (retain) NSMutableArray *Mensagem;

- (id)init;
@end
