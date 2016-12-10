package com.broadsense.iov.icloud.convert;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * 数据库获取到的List<Map>结果集转化为JavaBean工具类
 * @author yzChen
 * @date 2013-8-16 下午3:50:35
 * <pre>
 *	desc:
 * </pre>
 */
public class BeanUtils<T> {
	/**
	 * 根据List<Map<String, Object>>数据转换为JavaBean数据
	 * @param datas
	 * @param beanClass
	 * @return
	 * @throws CommonException
	 */
	public  List<T> ListMap2JavaBean(List<Map<String, Object>> datas, Class<T> beanClass) throws CommonException  {
		// 返回数据集合
		List<T> list = null;
		// 对象字段名称
		String fieldname = "";
		// 对象方法名称
		String methodname = "";
		// 对象方法需要赋的值
		Object methodsetvalue = "";
		try {
			list = new ArrayList<T>();
			// 得到对象所有字段
			Field fields[] = beanClass.getDeclaredFields();
			// 遍历数据
			for (Map<String, Object> mapdata : datas) {
				// 创建一个泛型类型实例
				T t = beanClass.newInstance();
				// 遍历所有字段，对应配置好的字段并赋值
				for (Field field : fields) {
					// 获取注解配置
					JavaBean javaBean = field.getAnnotation(JavaBean.class);
					if(null != javaBean) {	// 有注解配置，下一步操作
						// 全部转化为大写
						String dbfieldname = javaBean.dbfieldname();
						// 获取字段名称
						fieldname = field.getName();				
						// 拼接set方法
						methodname = "set" + StrUtil.capitalize(fieldname);
						// 获取data里的对应值			
						methodsetvalue = mapdata.get(dbfieldname);
				
						// 赋值给字段
						Method m = beanClass.getDeclaredMethod(methodname, field.getType());
						//System.out.println(" "+fieldname+" -"+methodsetvalue+" -"+methodname+" "+m);
						m.invoke(t, methodsetvalue);
					}
				}
				// 存入返回列表
				list.add(t);
			}
		} catch (InstantiationException e) {
			throw new CommonException(e, "创建beanClass实例异常");
		} catch (IllegalAccessException e) {
			throw new CommonException(e, "创建beanClass实例异常");
		} catch (SecurityException e) {
			throw new CommonException(e, "获取[" + fieldname + "] getter setter 方法异常");
		} catch (NoSuchMethodException e) {
			throw new CommonException(e, "获取[" + fieldname + "] getter setter 方法异常");
		} catch (IllegalArgumentException e) {
			throw new CommonException(e, "[" + methodname + "] 方法赋值异常");
		} catch (InvocationTargetException e) {
			throw new CommonException(e, "[" + methodname + "] 方法赋值异常");
		}
		// 返回
		return list;
	}

}
