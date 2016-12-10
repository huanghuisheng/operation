package com.broadsense.iov.icloud.convert;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 需要转换的对象字段注解配置类
 * @author yzChen
 * @date 2013-8-16 下午3:48:02
 * <pre>
 *	desc:
 * </pre>
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface JavaBean {

	// 数据字段名称（不区分大小写）
	public String dbfieldname();
	
}
