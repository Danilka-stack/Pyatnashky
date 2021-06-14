//
//  PlayField.h
//  Pyatnashki
//
//  Created by Daniil Reshetnyak on 6/1/19.
//  Copyright © 2019 Daniil Reshetnyak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"


@interface PlayField : NSObject 



@property NSInteger height;
@property NSInteger width;
@property NSMutableArray *cells;



-(instancetype)initWithSizeHeight:(NSInteger)height width:(NSInteger)width;
-(NSInteger)coordinatesOfEmptyCell;
-(BOOL)methodLeft:(NSInteger)coordinate;
-(BOOL)methodRight:(NSInteger)coordinate;
-(BOOL)methodButtom:(NSInteger)coordinate;
-(BOOL)methodTop:(NSInteger)coordinate;
-(BOOL)checkOfCondition;


@end


