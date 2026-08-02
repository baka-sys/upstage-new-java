package com.aska.common.util;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.lang.Nullable;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;

/**
 * BeanUtils
 * 提供bean转map和map转bean方法
 * @author zy
 */
@Slf4j
public class BeanUtils<T> extends org.springframework.beans.BeanUtils {
    public static Map<String,?> bean2Map(Object object) {
        Map<String,Object> map = new HashMap<>();
        if(object == null){
            return null;
        }
        try {
            BeanInfo beanInfo = Introspector.getBeanInfo(object.getClass());
            PropertyDescriptor[] propertyDescriptors = beanInfo.getPropertyDescriptors();
            for (PropertyDescriptor property : propertyDescriptors) {
                String key = property.getName();

                // 过滤class属性
                if (!"class".equals(key)) {
                    // 得到property对应的getter方法
                    Method getter = property.getReadMethod();

                    map.put(key, getter.invoke(object));
                }

            }
        } catch (IllegalAccessException | InvocationTargetException | IntrospectionException e) {
            log.error("错误",e);
        }
        return map;
    }

    public static <T> T map2Bean(Map<String,?> map,Class<T> c) {
        BeanInfo beanInfo = null;
        try {
            beanInfo = Introspector.getBeanInfo(c);
        } catch (IntrospectionException e) {
            log.error("获取BeanInfo错误",e);
        }
        T t = null;
        try {
            t = c.newInstance();
        } catch (InstantiationException | IllegalAccessException e) {
            log.error("获取实例错误",e);
        }
        PropertyDescriptor[] propertyDescriptors = beanInfo != null ? beanInfo.getPropertyDescriptors() : new PropertyDescriptor[0];
        for (PropertyDescriptor descriptor : propertyDescriptors) {
            String propertyName = descriptor.getName();
            if (map.containsKey(propertyName)) {
                Object value = map.get(propertyName);
                Object[] args = new Object[1];
                args[0] = value;
                //这里捕获异常为了让不正常的值可以暂时跳过不影响正常字段的赋值
                try {
                    descriptor.getWriteMethod().invoke(t, args);
                } catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
                    log.error("异常参数{},{}",t,args);
                    log.error("调用方法错误", e);
                }
            }
        }
        return t;
    }

    /**
     * 将目标源中不为空的字段过滤，将数据库中查出的数据源复制到提交的目标源中
     *
     * @param source 用id从数据库中查出来的数据源
     * @param target 提交的实体，目标源
     */
    public static void copyNullProperties(Object source, Object target) {
        copyProperties(source, target, getNoNullProperties(target));
    }

    /**
     * @param target 目标源数据
     * @return 将目标源中不为空的字段取出
     */
    private static String[] getNoNullProperties(Object target) {
        BeanWrapper srcBean = new BeanWrapperImpl(target);
        PropertyDescriptor[] pds = srcBean.getPropertyDescriptors();
        Set<String> noEmptyName = new HashSet<>();
        for (PropertyDescriptor p : pds) {
            Object value = srcBean.getPropertyValue(p.getName());
            if (value != null) {
                noEmptyName.add(p.getName());
            }
        }
        String[] result = new String[noEmptyName.size()];
        return noEmptyName.toArray(result);
    }

    public T deepCopy(Object source,Class<T> clazz) {
        String json = FastJsonConvert.convertObjectToJSON(source);
        return FastJsonConvert.convertJSONToObject(json,clazz);
    }

    public static void copyProperties(Object source, Object target) throws BeansException {
        copyProperties(source, target, null, (String[]) null);
    }

    private static void copyProperties(Object source, Object target, @Nullable Class<?> editable,
                                       @Nullable String... ignoreProperties) throws BeansException {

        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");

        Class<?> actualEditable = target.getClass();
        if (editable != null) {
            if (!editable.isInstance(target)) {
                throw new IllegalArgumentException("Target class [" + target.getClass().getName() +
                        "] not assignable to Editable class [" + editable.getName() + "]");
            }
            actualEditable = editable;
        }

        // 获取target对象的PropertyDescriptor属性数组targetPds
        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        List<String> ignoreList = (ignoreProperties != null ? Arrays.asList(ignoreProperties) : null);

        // 遍历target对象属性
        for (PropertyDescriptor targetPd : targetPds) {
            // 获取其setter方法
            Method writeMethod = targetPd.getWriteMethod();
            if (writeMethod != null && (ignoreList == null || !ignoreList.contains(targetPd.getName()))) {
                // 获取source对象与target对象targetPd属性同名的PropertyDescriptor对象sourcePd
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null) {
                    // 获取source对应属性的getter方法
                    Method readMethod = sourcePd.getReadMethod();
                    if (readMethod != null && ClassUtils.isAssignable(writeMethod.getParameterTypes()[0], readMethod.getReturnType())) {
                        try {
                            if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                                readMethod.setAccessible(true);
                            }
                            // 通过反射获取source对象属性的值
                            Object value = readMethod.invoke(source);
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }
                            // 通过反射给target对象属性赋值
                            writeMethod.invoke(target, value);
                        }
                        catch (Throwable ex) {
                            throw new FatalBeanException(
                                    "Could not copy property '" + targetPd.getName() + "' from source to target", ex);
                        }
                    }
                }
            }
        }
    }
}
