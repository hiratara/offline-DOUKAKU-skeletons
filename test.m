#import <Foundation/Foundation.h>
#import "answer_objc.h"

#if !__has_feature(objc_arc)
// "Manual Retain Release" is NOT supported in this file. "Automatic Reference Counting" ONLY.
#error MRR is NOT supported in this file. ARC ONLY.
#endif

static NSString *const InputFileName = @"patterns.tsv";

#pragma mark - InputPattern

@interface InputPattern : NSObject

@property (copy, readonly) NSString *name;
@property (copy, readonly) NSString *input;
@property (copy, readonly) NSString *expected;

// convenient creation
+ (InputPattern *)inputPatternWithString:(NSString *)inputString;

// designed initializer
- (InputPattern *)initWithString:(NSString *)inputString;

@end

@interface InputPattern ()

@property (copy, readwrite) NSString *name;
@property (copy, readwrite) NSString *input;
@property (copy, readwrite) NSString *expected;

@end

@implementation InputPattern

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"%@ (\n"// class name
            @"      name: %@\n"
            @"     input: %@\n"
            @"  expected: %@\n"
            @")"
            , NSStringFromClass([self class]) // class name
            , self.name
            , self.input
            , self.expected];
}

- (id)init
{
    return [self initWithString:nil];
}

+ (InputPattern *)inputPatternWithString:(NSString *)inputString
{
    return [[[self class] alloc] initWithString:inputString];
}

- (InputPattern *)initWithString:(NSString *)inputString
{
    self = [super init];
    if (self) {
        int const expectedCountOfComponents = 3;
        NSArray  *components                = [inputString componentsSeparatedByString:@"\t"];
        
        if ([components count] >= expectedCountOfComponents) {
            self.name     = [components objectAtIndex:0];
            self.input    = [components objectAtIndex:1];
            self.expected = [components objectAtIndex:2];
        }
        else {
            self = nil;
        }
    }
    return self;
}

@end

#pragma mark - main

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        NSError  *error     = nil;
        NSString *tsvString = [NSString stringWithContentsOfFile:InputFileName
                                                              encoding:NSUTF8StringEncoding
                                                                error:&error];
        int countOfCases    = 0;
        int countOfFailures = 0;
        
        if (!error) {
            NSScanner      *scanner             = [NSScanner scannerWithString:tsvString];
            NSCharacterSet *newlineCharacterSet = [NSCharacterSet newlineCharacterSet];
            NSString       *aLineString         = nil;
            
            while ([scanner scanUpToCharactersFromSet:newlineCharacterSet
                                           intoString:&aLineString] &&
                   [aLineString length] > 0)
            {
                InputPattern *inputPattern = [InputPattern inputPatternWithString:aLineString];
                
                if (inputPattern) {
                    countOfCases++;
                    NSString *solvedString = SolvedStringFromInputString(inputPattern.input);
                    
                    if (![solvedString isEqualToString:inputPattern.expected]) {
                        countOfFailures++;
                        NSLog(@"\n"
                              @"Failure in %@\n"
                              @"expected: \"%@\"\n"
                              @"  actual: \"%@\"\n"
                              , inputPattern.name
                              , inputPattern.expected
                              , solvedString);
                    }
                }
            }
        }
        else {
            NSLog(@"error: %@", [error localizedFailureReason]);
        }
        
        NSLog(@"\n"
              @"Cases: %d  Failures: %d"
              , countOfCases, countOfFailures);
    }
    return 0;
}

#pragma mark - usage

/*
% clang -fobjc-arc answer_objc.m test.m -o objc_test -framework Foundation && ./objc_test
*/


