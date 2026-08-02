package com.aska.common.util;

import cn.hutool.extra.pinyin.PinyinUtil;

public class ChineseToPinyinUtil{

    /**
     * 中文字符转换成首字母大写
     * @param chinese
     * @return
     */
    public static String getInitials(String chinese) {
        String pinyin = PinyinUtil.getFirstLetter(chinese,"");
        return pinyin.toUpperCase();
    }
}
