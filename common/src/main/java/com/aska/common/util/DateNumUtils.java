package com.aska.common.util;

import cn.hutool.core.date.DateUtil;

import java.util.Arrays;

/**
 * 时间编号工具类
 * @author Charlotte
 */
public class DateNumUtils {

    /**
     * 物质类编码长度
     */
    public final static Integer NUMBER_LENGTH = 6;

    /**
     * 订单类编码长度
     */
    public final static Integer TIME_NUMBER_LENGTH = 3;

    /**
     * 物质类型编码生成：编码前缀（公司编码+分类编码）+数字编码
     * @param prefixCode 唯一编码前缀
     * @param code  最新编码
     * @return
     */
    public static String generateOnlyCode(String prefixCode,String code){
        // 默认一个初始设备编号
        String newCode = "";
        // 判断传入的设备类型与最新设备编号不为空
        if(code != null && !code.isEmpty()){
            // 去掉前缀,字符串数字解析为整数
            String intString = code.substring(prefixCode.length(),code.length());
            int no = Integer.parseInt(intString);
            // 最新设备编号自增1
            int newCodeNum = ++no;
            // 将整数格式化为5位数字
            newCode = String.format(prefixCode + "%0".concat(String.valueOf(NUMBER_LENGTH)).concat("d"), newCodeNum);
        } else {
            char[] zeroArray = new char[NUMBER_LENGTH-1];
            Arrays.fill(zeroArray,'0');
            String zeros = new String(zeroArray);
            newCode = prefixCode + zeros + "1";
        }
        return newCode;
    }

    /**
     * 订单类编码: 编码前缀+时间+数字
     * @param prefixCode
     * @param code
     * @return
     */
    public static String generateOnlyCodeByTime(String prefixCode,String code){
        // 默认一个初始设备编号
        String newCode = "";
        char[] zeroArray = new char[TIME_NUMBER_LENGTH-1];
        Arrays.fill(zeroArray,'0');
        String zeros = new String(zeroArray);
        String sdf = DateUtil.format(DateUtil.date(),"yyyyMMdd");
        // 判断传入的设备类型与最新设备编号不为空
        if(code != null && !code.isEmpty()){
            // 去掉前缀,字符串数字解析为整数
            int no = Integer.parseInt(code.substring(code.length()-TIME_NUMBER_LENGTH));
            // 最新设备编号自增1
            int newCodeNum = ++no;
            // 将整数格式化为5位数字
            newCode = String.format(prefixCode + sdf + "%0".concat(String.valueOf(TIME_NUMBER_LENGTH-1)).concat("d"), newCodeNum);
        } else {
            newCode = prefixCode + sdf + zeros + "1";
        }
        return newCode;
    }


}
