//
//  main.m
//  Task2
//
//  Created by Andrei Grishkin on 4/4/20.
//
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        for (int i = 5; i < 51; i+=5)
            NSLog(@"'%i': '%i'",i,i*(i+1)/2, @"\n");
    }
    return 0;
} 
