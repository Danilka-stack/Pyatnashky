//
//  PlayField.m
//  Pyatnashki
//
//  Created by Daniil Reshetnyak on 6/1/19.
//  c © 2019 Daniil Reshetnyak. All rights reserved.
//

#import "PlayField.h"

@implementation PlayField


-(BOOL)checkOfCondition;
{
    BOOL b = YES;
    for (NSInteger i = 0; i<15; i++) {
    
        Cell *cell1 = self.cells[i];
        NSLog(@"Cell1 = %ld",cell1.number);
        Cell *cell2 = self.cells[i+1];
        NSLog(@"Cell2 = %ld",cell2.number);
        NSInteger raznitca = cell2.number-cell1.number;
        
        if (raznitca>1) {
            
            return NO;
            
        }
        
        if (i == 14 && b == YES) {
        
                return YES;
        }
    }
    return NO;
}


-(instancetype)initWithSizeHeight:(NSInteger)height width:(NSInteger)width
{
    
    self = [super init];
    if (self) {
        
        self.height = height;
        self.width = width;
        
        NSInteger count = width*height;

        NSMutableArray *cells = [NSMutableArray arrayWithCapacity:count];
       
        
        for (NSInteger y = 1; y<count+1; y++) {
    
            Cell *cell = [[Cell alloc]init];
            cell.coordinate = y;
            cell.state = 1;
            
        
         
            if (y==count) {
                cell.state = 0;
            }
            
            [cells addObject:cell];
            
        }
        
        
        self.cells = cells; 
        
    }
    
    return self;
    
}


- (NSInteger )coordinatesOfEmptyCell
{
    
    for (Cell *cell in self.cells) {
        
        if (cell.state == 0) {
            return cell.coordinate;
        }
        
    }
    
    return 0;
}

- (BOOL)methodLeft:(NSInteger)coordinate
{
    
    for (NSInteger i = 0;i<self.cells.count;i++) {
        
        Cell *cell = self.cells[i];
        if (cell.coordinate == coordinate) {
            
            NSInteger index = i-1;
            Cell *c = self.cells[index];
            
            if (c.state == 0) {
                
                [self.cells exchangeObjectAtIndex:i withObjectAtIndex:index];
                
                
                Cell *object = self.cells[i];
                Cell *object2 = self.cells[index];
                NSInteger crd = object.coordinate;
                object.coordinate = object2.coordinate;
                object2.coordinate = crd;
                return YES;
                
            }
            else{
                
                return NO;
            }
            
        }
        
    }
    return YES;
    
}

- (BOOL)methodRight:(NSInteger)coordinate
{

            NSInteger index = coordinate;
            Cell *c = self.cells[index];
            
            if (c.state == 0) {
                
            [self.cells exchangeObjectAtIndex:coordinate-1 withObjectAtIndex:index];
                
                
                Cell *object = self.cells[coordinate-1];
                Cell *object2 = self.cells[index];
                NSInteger crd = object.coordinate;
                object.coordinate = object2.coordinate;
                object2.coordinate = crd;                                   //
                
                
                return YES;
            
        }
            else{
                
                return NO;
            }


    return YES;
    
}



- (BOOL)methodTop:(NSInteger)coordinate
{
    

    for (NSInteger i = 0; i<self.cells.count; i++) {
        
        Cell *cell = self.cells[i];
        if(cell.coordinate == coordinate){
            
            NSInteger index = i-self.width;
            Cell *c = self.cells[index];
            
            if (c.state == 0) {
                
                [self.cells exchangeObjectAtIndex:i withObjectAtIndex:index];
                
                
                Cell *object = self.cells[i];
                Cell *object2 = self.cells[index];
                NSInteger crd = object.coordinate;
                object.coordinate = object2.coordinate;
                object2.coordinate = crd;
                
                return YES;
        
                
            }
            else{
                return NO;
                
            }
            
        }
        
    }
    return YES;
    
}

- (BOOL)methodButtom:(NSInteger)coordinate
{
   
        for (NSInteger i = 0;i<self.cells.count;i++) {
            
            Cell *cell = self.cells[i];
            if (cell.coordinate == coordinate) {
                
                NSInteger index = i+self.width;
                Cell *c = self.cells[index];
                
                if (c.state == 0) {
                    
                    [self.cells exchangeObjectAtIndex:i withObjectAtIndex:index];
                    
                    Cell *object = self.cells[i];
                    Cell *object2 = self.cells[index];
                    NSInteger crd = object.coordinate;
                    object.coordinate = object2.coordinate;
                    object2.coordinate = crd;
                  
                    return YES;
                    
                }
                
                else{
                    
                    return NO;
                
            }
            
        }
    }
    return YES;
    
}



    @end
