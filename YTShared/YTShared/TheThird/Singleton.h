

//.m
#if __has_feature(objc_arc)
#define Singleton_h(name) +(instancetype)shared##name;


#define Singleton_m(name) static id _instanceType;\
+(instancetype)shared##name\
{\
if (_instanceType==nil) {\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instanceType = [[self alloc]init];\
});\
}\
return _instanceType;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (_instanceType==nil) {\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instanceType = [super allocWithZone:zone];\
});\
}\
return _instanceType;\
}\
\
- (instancetype)copyWithZone:(NSZone *)zone\
{\
return _instanceType;\
}
#else
#define Singleton_h(name) +(instancetype)shared##name;
#define Singleton_m(name) static id _instanceType;\
+(instancetype)shared##name\
{\
if (_instanceType==nil) {\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instanceType = [[self alloc]init];\
});\
}\
return _instanceType;\
}\
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone\
{\
if (_instanceType==nil) {\
\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instanceType = [super allocWithZone:zone];\
});\
}\
return _instanceType;\
}\
\
- (instancetype)copyWithZone:(NSZone *)zone\
{\
return _instanceType;\
}\
- (oneway void)release\
{\
    \
}\
-(instancetype)retain\
{\
    return _instanceType;\
}\
- (instancetype)autorelease\
{\
    return _instanceType;\
}\
- (NSUInteger)retainCount\
{\
    return 1;\
}
#endif
