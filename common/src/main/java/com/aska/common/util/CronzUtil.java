package com.aska.common.util;

import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;

import java.util.Date;

public class CronzUtil {

        /**
         *构建Cron表达式 举例: 当前时间开始每3天执行一次需传参 new Date(),3,1
         *                    当前时间开始每5个月执行一次需传参 new Date(),5,2
         * @param  date 开始时间
         * @param  count 数量
         * @param  type 类型:0->小时 type 1->天 type 2->周  type 3->月 type 4->季度 type 5->年 6->分钟,7->定时提醒
         * @return String
         */
        public static String createCronExpression(Date date, Integer count, Integer type){
            StringBuffer cronExp = new StringBuffer("");
            if(type == 7){
                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                int day =  DateUtil.dayOfMonth(date);
                int month = DateUtil.month(date) + 1;
                int year = DateUtil.year(date);

                cronExp.append(second).append(" ");

                cronExp.append(minute).append(" ");

                cronExp.append(hour).append(" ");

                cronExp.append(day).append(" ");

                cronExp.append(month).append(" ");

                cronExp.append("? ");

                cronExp.append(year);
                return cronExp.toString();
            }
            if (count==0){
                throw new RuntimeException("错误数量填写");
            }
            //如果为小时
            if (type ==0){
                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //让小时部分去加一下几个小时以后执行
                hour = hour + count;
                if (hour>24){
                    //大于24考虑大于多少个24
                    int b=hour/24;
                    //偏移大于几个24就偏移几天
                    DateTime dateTime = DateUtil.offsetDay(date, b);
                    //然后小时去剪去大于的24
                    hour=hour-b*24;
                    //获取日
                    int day = DateUtil.dayOfMonth(dateTime);
                    //获取月
                    int month = DateUtil.month(dateTime);
                    //月份需加1因为 糊涂工具类是从0开始算的
                    month=month+1;
                    //获取年份
                    int year = DateUtil.year(dateTime);
                    cronExp.append(second).append(" ");
                    cronExp.append(minute).append(" ");
                    cronExp.append(hour).append(" ");
                    cronExp.append(day).append(" ");
                    cronExp.append(month).append(" ");
                    cronExp.append("? ");
                    cronExp.append(year).append("-").append(year);
                }else {
                    cronExp.append(second).append(" ");
                    cronExp.append(minute).append(" ");
                    cronExp.append(hour).append(" ");
                    cronExp.append("* ");
                    cronExp.append("* ");
                    cronExp.append("? ");
                    cronExp.append("*");
                    return cronExp.toString();
                }
            }

            //如果为天
            if (type==1){
                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //偏移count天
                DateTime dateTime = DateUtil.offsetDay(new Date(), count);
                //获取日
                int day = DateUtil.dayOfMonth(dateTime);
                //获取月
                int month = DateUtil.month(dateTime);
                //月份需加1因为 糊涂工具类是从0开始算的
                month=month+1;
                //获取年份
                int year = DateUtil.year(dateTime);
                cronExp.append(second).append(" ");
                cronExp.append(minute).append(" ");
                cronExp.append(hour).append(" ");
                cronExp.append(day).append(" ");
                cronExp.append(month).append(" ");
                cronExp.append("? ");
                cronExp.append(year).append("-").append(year);
                return cronExp.toString();
            }

            //如果为周
            if (type ==2){
                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //偏移个count*7天
                DateTime dateTime = DateUtil.offsetDay(new Date(), count*7);
                //获取日
                int day = DateUtil.dayOfMonth(dateTime);
                //获取月
                int month = DateUtil.month(dateTime);
                //月份需加1因为 糊涂工具类是从0开始算的
                month=month+1;
                //获取年份
                int year = DateUtil.year(dateTime);
                cronExp.append(second).append(" ");
                cronExp.append(minute).append(" ");
                cronExp.append(hour).append(" ");
                cronExp.append(day).append(" ");
                cronExp.append(month).append(" ");
                cronExp.append("? ");
                cronExp.append(year).append("-").append(year);
                return cronExp.toString();
            }
            //如果为月
            if (type ==3){
                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //偏移个count*30天
                DateTime dateTime = DateUtil.offsetDay(new Date(), count*30);
                //获取日
                int day = DateUtil.dayOfMonth(dateTime);
                //获取月
                int month = DateUtil.month(dateTime);
                //月份需加1因为 糊涂工具类是从0开始算的
                month=month+1;
                //获取年份
                int year = DateUtil.year(dateTime);
                cronExp.append(second).append(" ");
                cronExp.append(minute).append(" ");
                cronExp.append(hour).append(" ");
                cronExp.append(day).append(" ");
                cronExp.append(month).append(" ");
                cronExp.append("? ");
                cronExp.append(year).append("-").append(year);
                return cronExp.toString();
            }
            //如果为季度
            if (type ==4){

                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //偏移个count*90天
                DateTime dateTime = DateUtil.offsetDay(new Date(), count*90);
                //获取日
                int day = DateUtil.dayOfMonth(dateTime);
                //获取月
                int month = DateUtil.month(dateTime);
                //月份需加1因为 糊涂工具类是从0开始算的
                month=month+1;
                //获取年份
                int year = DateUtil.year(dateTime);
                cronExp.append(second).append(" ");
                cronExp.append(minute).append(" ");
                cronExp.append(hour).append(" ");
                cronExp.append(day).append(" ");
                cronExp.append(month).append(" ");
                cronExp.append("? ");
                cronExp.append(year).append("-").append(year);
                return cronExp.toString();
            }


            //如果为年
            if (type ==5){

                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //获取日
                int day = DateUtil.dayOfMonth(date);
                //获取月
                int month = DateUtil.month(date);
                //月份需加1因为 糊涂工具类是从0开始算的
                month=month+1;
                //获取年份直接+count就行
                int year = DateUtil.year(date)+count;

                cronExp.append(second).append(" ");
                cronExp.append(minute).append(" ");
                cronExp.append(hour).append(" ");
                cronExp.append(day).append(" ");
                cronExp.append(month).append(" ");
                cronExp.append("? ");
                cronExp.append(year).append("-").append(year);
                return cronExp.toString();
            }
            //如果为分钟
            if (type ==6){
                //小时
                int hour = DateUtil.hour(date,true);
                //分钟
                int minute = DateUtil.minute(date);
                //秒
                int second = DateUtil.second(date);
                //让小时部分去加一下几个小时以后执行
                minute=minute+count;
                if (minute>60){
                    //大于24考虑大于多少个24
                    int b=minute/60;
                    minute=minute-b*60;
                    if (hour+b>24){
                        int c=hour/24;
                        //然后小时去剪去大于的24
                        hour=hour-c*24;
                        //偏移大于几个24就偏移几天
                        date = DateUtil.offsetDay(date, c);
                        //获取日
                        int day = DateUtil.dayOfMonth(date);
                        //获取月
                        int month = DateUtil.month(date);
                        //月份需加1因为 糊涂工具类是从0开始算的
                        month=month+1;
                        //获取年份
                        int year = DateUtil.year(date);
                        cronExp.append(second).append(" ");
                        cronExp.append(minute).append(" ");
                        cronExp.append(hour).append(" ");
                        cronExp.append(day).append(" ");
                        cronExp.append(month).append(" ");
                        cronExp.append("? ");
                        cronExp.append(year).append("-").append(year);

                    }else {
                        //获取日
                        int day = DateUtil.dayOfMonth(date);
                        //获取月
                        int month = DateUtil.month(date);
                        //月份需加1因为 糊涂工具类是从0开始算的
                        month=month+1;
                        //获取年份
                        int year = DateUtil.year(date);
                        cronExp.append(second).append(" ");
                        cronExp.append(minute).append(" ");
                        cronExp.append(hour).append(" ");
                        cronExp.append(day).append(" ");
                        cronExp.append(month).append(" ");
                        cronExp.append("? ");
                        cronExp.append(year).append("-").append(year);
                    }
                }else {
                    cronExp.append(second).append(" ");
                    cronExp.append(minute).append(" ");
                    cronExp.append(hour).append(" ");
                    cronExp.append("* ");
                    cronExp.append("* ");
                    cronExp.append("? ");
                    cronExp.append("*");
                    return cronExp.toString();
                }
            }

            return null;
        }
}
