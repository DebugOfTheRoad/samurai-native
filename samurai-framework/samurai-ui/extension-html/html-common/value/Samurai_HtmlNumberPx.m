//
//     ____    _                        __     _      _____
//    / ___\  /_\     /\/\    /\ /\    /__\   /_\     \_   \
//    \ \    //_\\   /    \  / / \ \  / \//  //_\\     / /\/
//  /\_\ \  /  _  \ / /\/\ \ \ \_/ / / _  \ /  _  \ /\/ /_
//  \____/  \_/ \_/ \/    \/  \___/  \/ \_/ \_/ \_/ \____/
//
//	Copyright Samurai development team and other contributors
//
//	http://www.samurai-framework.com
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "Samurai_HtmlNumberPx.h"

#import "_pragma_push.h"

#if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

// ----------------------------------
// Source code
// ----------------------------------

#pragma mark -

@implementation SamuraiHtmlNumberPx

+ (instancetype)object:(id)any
{
	if ( [any isKindOfClass:[NSString class]] )
	{
		NSString * str = any;
		
		if ( 0 == str.length )
			return nil;
	
		if ( [str isEqualToString:@"0"] || [str isNumber] )
		{
			SamuraiHtmlNumberPx * value = [[self alloc] init];
			
			value.value = [str floatValue];
			value.unit = @"px";
			
			return value;
		}

		for ( NSString * suffix in @[ @"px" ] )
		{
			if ( [str hasSuffix:suffix] )
			{
				SamuraiHtmlNumberPx * value = [[self alloc] init];

				value.value = [[str substringToIndex:(str.length - suffix.length)] floatValue];
				value.unit = [str substringFromIndex:(str.length - suffix.length)];

				return value;
			}
		}
	}

	return nil; // [super object:any];
}

+ (instancetype)number:(CGFloat)value
{
	SamuraiHtmlNumberPx * number = [[self alloc] init];
	number.value = value;
	return number;
}

- (id)init
{
	self = [super init];
	if ( self )
	{
		self.value = 0.0f;
		self.unit = @"px";
	}
	return self;
}

- (void)dealloc
{
}

- (BOOL)isConstant
{
	return YES;
}

- (CGFloat)computeValue:(CGFloat)value
{
	return self.value;
}

@end

// ----------------------------------
// Unit test
// ----------------------------------

#pragma mark -

#if __SAMURAI_TESTING__

TEST_CASE( UI, HtmlNumberPx )
{
//	TODO( @"test case" )
}
TEST_CASE_END

#endif	// #if __SAMURAI_TESTING__

#endif	// #if (TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR)

#import "_pragma_pop.h"
