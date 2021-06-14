//
//  ViewController.m
//  Pyatnashki
//
//  Created by Daniil Reshetnyak on 6/1/19.
//  Copyright © 2019 Daniil Reshetnyak. All rights reserved.
//

#import "ViewController.h"
#import "PlayField.h"

@interface ViewController ()


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init mainView
    CGFloat maxX = CGRectGetMaxX(self.view.frame);
    CGFloat maxY = CGRectGetMaxY(self.view.frame);
    NSInteger currentX = 20;
    NSInteger currentY = 164;
    
    self.mainView = [[UIView alloc]init];
    self.mainView.backgroundColor = UIColor.grayColor;
    self.mainView.frame = CGRectMake(currentX, currentY, (maxX-currentX)-20, (maxY-currentY)-124);
    
    
    [self.view addSubview:self.mainView];
    
    //init PlayField
    
    self.playField = [[PlayField alloc]initWithSizeHeight:4 width:4];
    
    //creating cell for mainView
    
    NSInteger x = 0;
    NSInteger y = 0;
    NSInteger width = self.mainView.frame.size.width/self.playField.width;
    NSInteger height = self.mainView.frame.size.height/self.playField.height;
    
    self.coordinates = [[NSMutableDictionary alloc]init];
    
    
    for (NSInteger i = 1; i<self.playField.cells.count+1; i++) {
        
        for (NSInteger a = self.playField.width+1; a<self.playField.cells.count; a = a + self.playField.width) {
            
            if ( a == i) {
                
                x = 0.0;
                y = y + height;
                
                
            }
            
        }
        
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        
        
        UILabel *labelCell = [[UILabel alloc]init];
        labelCell.frame = CGRectMake(x, y, width, height);
        labelCell.backgroundColor = UIColor.redColor;
        
        
        
        
        labelCell.tag = i;
        labelCell.layer.borderColor = [UIColor whiteColor].CGColor;
        labelCell.textAlignment = NSTextAlignmentCenter;
        labelCell.layer.borderWidth = 3.0f;
        labelCell.userInteractionEnabled = YES;
        
        
        [labelCell addGestureRecognizer:panRecognizer];
        
        
        x = x + width;
        
        
        CGRect rect = labelCell.frame;
        NSValue *value = [NSValue valueWithCGRect:rect];
        NSString *string = [NSString stringWithFormat:@"%ld",(long)i];
        [self.coordinates setObject:value forKey:string];
        
        NSInteger index = i-1;
        Cell *cell = self.playField.cells[index];
        
        
        if (i == self.playField.width*self.playField.height) {
            
            labelCell = nil;
            cell.number = 16;
            self.playField.cells[15] = cell;
            
            
            
        }
        else{
            
            
            
            NSInteger value = [self valueForCell];
            
            cell.number = value;
            
            labelCell.text = [NSString stringWithFormat:@"%ld",value];
            
            self.playField.cells[index] = cell;
            
            
        }
        
        [self.mainView addSubview:labelCell];
        
    }
    
    self.defaultCoordinate = self.coordinates;
    
    for (Cell *cell in self.playField.cells) {
        
        
        NSLog(@"%ld",cell.number);
        
    }
}



-(BOOL)borderIntersectionCheckWithLocation:(CGPoint)location
{
    
    CGFloat MVMaxY = CGRectGetMaxY(self.mainView.bounds);
    
    if (location.y > MVMaxY ) {
    
        return NO;
        
    }
    
    CGFloat MVMaxX = CGRectGetMaxX(self.mainView.bounds);
    
    if (location.x > MVMaxX) {
        
        return NO;
        
    }
    
    
    CGFloat MVMinY = CGRectGetMinY(self.mainView.bounds);
    
    if (location.y < MVMinY) {
     
        return NO;
        
    }
    
    CGFloat MVMinX = CGRectGetMinX(self.mainView.bounds);
    
    if (location.x < MVMinX) {
        
        return NO;
        
    }
    
    
    return YES;
}
- (void)checkOfCondition
{
    
    BOOL b = [self.playField checkOfCondition];
    
    if(b == YES){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You are winner" message:@"You are genius like Oleksandr Kosylov" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else{
        
        return;
        
    }
    
}

- (void)cellMovementWithDirectionType:(DirectionType)directionType andRecognizer:(UIPanGestureRecognizer *)recognizer{
    
    NSString *string;
    NSValue *value = self.coordinates[string];
    CGRect rect = [value CGRectValue];
    BOOL a;
    
    recognizer.view.frame = rect;
    


    if(directionType == DirectionTypeTop) {
        
        a = [self.playField methodTop:recognizer.view.tag];
        
        if(a == YES){
            
            string = [NSString stringWithFormat:@"%ld",recognizer.view.tag-self.playField.width];
            recognizer.view.tag = recognizer.view.tag - self.playField.width;
            
            [self checkOfCondition];
            
            return;
            
        }
        
        else{
            
            string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
            
        }
        
    }
    
    
    
    
        
        if (directionType == DirectionTypeBottom) {
            
            a = [self.playField methodButtom:recognizer.view.tag];
            
            if(a == YES)
            {
            string = [NSString stringWithFormat:@"%ld",recognizer.view.tag+self.playField.width];
            recognizer.view.tag = recognizer.view.tag + self.playField.width;
            [self checkOfCondition];
            
            return;
            
        }
            else{
                
                string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
                
            }
            
        
            return;
    }
    
    
    
    
    if (directionType == DirectionTypeLeft) {
        
        a = [self.playField methodLeft:recognizer.view.tag];
        
        if (a == YES) {
            
             string = [NSString stringWithFormat:@"%ld",recognizer.view.tag-1];
            recognizer.view.tag = recognizer.view.tag-1;
            [self checkOfCondition];
            
            return;
            
        }
        else{
            
            
            string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
            
        }
        
        return;
        
    }
    
    
    if (directionType == DirectionTypeRight) {
        
        a = [self.playField methodRight:recognizer.view.tag];
        
        if (a == YES) {
            
            string = [NSString stringWithFormat:@"%ld",recognizer.view.tag+1];
            recognizer.view.tag = recognizer.view.tag + 1;
            [self checkOfCondition];
            
            return;
        }
        
        else{
            
              string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
            
        }
        
        return;
    }

    
    
    
}
- (NSInteger)randomValueBetween:(NSInteger)min and:(NSInteger)max {
    return (NSInteger)(min + arc4random_uniform(max - min + 1));
}


- (NSInteger)valueForCell
{
    
    NSInteger integer = [self randomValueBetween:1 and:15];
    BOOL b;
    NSString *string = [NSString stringWithFormat:@"%ld",(long)integer];
   
    
    for (UILabel *lbl in self.mainView.subviews) {
        
        NSLog(@"%@",lbl.text);
        
    }
    
    for (UILabel *lbl in self.mainView.subviews) {
    
        b = ![lbl.text isEqualToString:string];
        if (b == NO)
            
            return [self valueForCell];
            
        }
    
    return integer;


}
    

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
    {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];//
        CGPoint location = [recognizer locationInView:recognizer.view.superview];
        
        recognizer.view.center = location;
        
        NSLog(@"%f  %f",location.x,location.y);
        NSString *string;
        NSValue *value = self.coordinates[string];
        CGRect rect = [value CGRectValue];
        BOOL a;
        
        
        if (recognizer.state == UIGestureRecognizerStateEnded) {
        
            BOOL b = [self borderIntersectionCheckWithLocation:location];
            
            if(b == NO)
            {
                string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
                value  = self.coordinates[string];
                rect = [value CGRectValue];
                recognizer.view.frame = rect;

                return;
            }
            
            NSInteger number = -labs(30);
            NSInteger number2 = -labs(150);
            
            
            
           if (translation.y<number && translation.y>number2) {//if there was move to the top
               
               [self cellMovementWithDirectionType:DirectionTypeTop andRecognizer:recognizer];

            }
            
        
            
            
            if (translation.x<number && translation.x>number2) {//if there was move on the left
                
                [self cellMovementWithDirectionType:DirectionTypeLeft andRecognizer:recognizer];
            }
        
        
            
            
            if (translation.y>30 && translation.y<150) {// if there was move on the bottom
                
                [self cellMovementWithDirectionType:DirectionTypeBottom andRecognizer:recognizer];
                
            }
            
            
            
        
            
            if (translation.x>30 && translation.x<150) { //if there was move to the right
                
                
                a = [self.playField methodRight:recognizer.view.tag];


                if (a == YES) {

                    string = [NSString stringWithFormat:@"%ld",recognizer.view.tag+1];
                    value  = self.coordinates[string];
                    rect = [value CGRectValue];
                    recognizer.view.frame = rect;

                    recognizer.view.tag = recognizer.view.tag + 1;



                    BOOL b = NO;
                    b = [self.playField checkOfCondition];

                    if(b == YES){

                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"You are winner" message:@"You are genius like Oleksandr Kosylov" preferredStyle:UIAlertControllerStyleAlert];

                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
                        [alert addAction:cancelAction];

                        [self presentViewController:alert animated:YES completion:nil];

                    }

                    return;

                }
                else {
                    string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
                    value  = self.coordinates[string];
                    rect = [value CGRectValue];
                    recognizer.view.frame = rect;

                    return;


                }

                return;

            }

            string = [NSString stringWithFormat:@"%ld",recognizer.view.tag];
            value  = self.coordinates[string];
            rect = [value CGRectValue];
            recognizer.view.frame = rect;

        }
        
    }



@end
    
            
