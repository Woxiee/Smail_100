 

#import <Foundation/Foundation.h>

@interface WHC_ModelSqlite : NSObject

/**
 * 说明: 存储模型数组到本地(事务方式)
 * @param model_array 模型数组对象(model_array 里对象类型要一致)
 */

+ (void)insertArray:(NSArray *)model_array;

/**
 * 说明: 存储模型到本地
 * @param model_object 模型对象
 */

+ (void)insert:(id)model_object;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @return 查询模型对象数组
 */

+ (NSArray *)query:(Class)model_class;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则查询所有)
 * @return 查询模型对象数组
 */

+ (NSArray *)query:(Class)model_class where:(NSString *)where;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param order 排序条件(排序语法和SQL order 查询语法一样，order为空则不排序)
 * @return 查询模型对象数组
 */

/// example: [WHC_ModelSqlite query:[Person class] order:@"by age desc/asc"];
/// 对person数据表查询并且根据age自动降序或者升序排序

+ (NSArray *)query:(Class)model_class order:(NSString *)order;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param limit 限制条件(限制语法和SQL limit 查询语法一样，limit为空则不限制查询)
 * @return 查询模型对象数组
 */

/// example: [WHC_ModelSqlite query:[Person class] limit:@"8"];
/// 对person数据表查询并且并且限制查询数量为8
/// example: [WHC_ModelSqlite query:[Person class] limit:@"8 offset 8"];
/// 对person数据表查询并且对查询列表偏移8并且限制查询数量为8

+ (NSArray *)query:(Class)model_class limit:(NSString *)limit;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则查询所有)
 * @param order 排序条件(排序语法和SQL order 查询语法一样，order为空则不排序)
 * @return 查询模型对象数组
 */

/// example: [WHC_ModelSqlite query:[Person class] where:@"age < 30" order:@"by age desc/asc"];
/// 对person数据表查询age小于30岁并且根据age自动降序或者升序排序

+ (NSArray *)query:(Class)model_class where:(NSString *)where order:(NSString *)order;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则查询所有)
 * @param limit 限制条件(限制语法和SQL limit 查询语法一样，limit为空则不限制查询)
 * @return 查询模型对象数组
 */

/// example: [WHC_ModelSqlite query:[Person class] where:@"age <= 30" limit:@"8"];
/// 对person数据表查询age小于30岁并且限制查询数量为8
/// example: [WHC_ModelSqlite query:[Person class] where:@"age <= 30" limit:@"8 offset 8"];
/// 对person数据表查询age小于30岁并且对查询列表偏移8并且限制查询数量为8

+ (NSArray *)query:(Class)model_class where:(NSString *)where limit:(NSString *)limit;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param order 排序条件(排序语法和SQL order 查询语法一样，order为空则不排序)
 * @param limit 限制条件(限制语法和SQL limit 查询语法一样，limit为空则不限制查询)
 * @return 查询模型对象数组
 */

/// example: [WHC_ModelSqlite query:[Person class] order:@"by age desc/asc" limit:@"8"];
/// 对person数据表查询并且根据age自动降序或者升序排序并且限制查询的数量为8
/// example: [WHC_ModelSqlite query:[Person class] order:@"by age desc/asc" limit:@"8 offset 8"];
/// 对person数据表查询并且根据age自动降序或者升序排序并且限制查询的数量为8偏移为8

+ (NSArray *)query:(Class)model_class order:(NSString *)order limit:(NSString *)limit;

/**
 * 说明: 查询本地模型对象
 * @param model_class 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则查询所有)
 * @param order 排序条件(排序语法和SQL order 查询语法一样，order为空则不排序)
 * @param limit 限制条件(限制语法和SQL limit 查询语法一样，limit为空则不限制查询)
 * @return 查询模型对象数组
 */

/// example: [WHC_ModelSqlite query:[Person class] where:@"age <= 30" order:@"by age desc/asc" limit:@"8"];
/// 对person数据表查询age小于30岁并且根据age自动降序或者升序排序并且限制查询的数量为8
/// example: [WHC_ModelSqlite query:[Person class] where:@"age <= 30" order:@"by age desc/asc" limit:@"8 offset 8"];
/// 对person数据表查询age小于30岁并且根据age自动降序或者升序排序并且限制查询的数量为8偏移为8

+ (NSArray *)query:(Class)model_class where:(NSString *)where order:(NSString *)order limit:(NSString *)limit;

/**
 * 说明: 更新本地模型对象
 * @param model_class 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则更新所有)
 */

+ (void)update:(id)model_object where:(NSString *)where;

/**
 * 说明: 清空本地模型对象
 * @param model_class 模型类
 */

+ (void)clear:(Class)model_class;


/**
 * 说明: 删除本地模型对象
 * @param model_class 模型类
 * @param where 查询条件(查询语法和SQL where 查询语法一样，where为空则删除所有)
 */

+ (void)delete:(Class)model_class where:(NSString *)where;

/**
 * 说明: 清空所有本地模型数据库
 */

+ (void)removeAllModel;

/**
 * 说明: 清空指定本地模型数据库
 * @param model_class 模型类
 */

+ (void)removeModel:(Class)model_class;

/**
 * 说明: 返回本地模型数据库路径
 * @param model_class 模型类
 * @return 路径
 */

+ (NSString *)localPathWithModel:(Class)model_class;

/**
 * 说明: 返回本地模型数据库版本号
 * @param model_class 模型类
 * @return 版本号
 */
+ (NSString *)versionWithModel:(Class)model_class;

@end
