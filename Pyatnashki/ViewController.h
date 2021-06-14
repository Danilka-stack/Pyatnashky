//
//  ViewController.h
//  Pyatnashki
//
//  Created by Daniil Reshetnyak on 6/1/19.
//  Copyright © 2019 Daniil Reshetnyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayField.h"

@interface ViewController : UIViewController

typedef NS_ENUM(NSInteger,DirectionType)
{
    DirectionTypeTop,
    DirectionTypeBottom,
    DirectionTypeLeft,
    DirectionTypeRight,
};


@property NSMutableArray *objects;
@property PlayField *playField;
@property UIView *mainView;
@property NSMutableDictionary *coordinates;
@property NSMutableDictionary *defaultCoordinate;

-(BOOL)borderIntersectionCheckWithLocation:(CGPoint)location;
-(void)checkOfCondition;
-(void)cellMovementWithDirectionType:(DirectionType)directionType andRecognizer:(UIPanGestureRecognizer *)recognizer;
-(void)handlePan:(UIPanGestureRecognizer *)recognizer;
-(NSInteger)randomValueBetween:(NSInteger)min and:(NSInteger)max;
-(NSInteger)valueForCell;


@end

