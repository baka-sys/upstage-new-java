package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.RedisUtil;
import com.aska.logical.service.auth.IUrlService;
import com.aska.repository.entity.Url;
import com.aska.repository.mapper.UrlMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * <p>
 * 域名表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-17
 */
@Service
public class UrlServiceImpl extends ServiceImpl<UrlMapper, Url> implements IUrlService {

    @Autowired
    UrlMapper mapper;

    @Autowired
    RedisUtil redisUtil;


    private final static String CONFIG_NAME = "customer-id-";

    /**
     * 子账号集合
     */
    private final static String CONFIG_ACCOUNT_NAME = "account-id-";


    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public Map<String,String> addAndUpdateByUrl(Url url) {
        Map<String,String> map = new HashMap<String,String>();
        QueryWrapper<Url> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Url::getUserId, url.getUserId()).eq(Url::getAccountType, url.getAccountType());
        List<Url> urlList = mapper.selectList(queryWrapper);
        List<String> strings = Arrays.asList(url.getUrl().split(","));
        map.put("domain",url.getUrl());
        if(urlList!=null && urlList.size()>0){
            // 删除全部，并重新添加,删除nginx配置文件
            mapper.delete(queryWrapper);
        }
        if(strings !=null && strings.size() > 0){
            //查询域名是不是存在重复
            List<Url> urlList1 = mapper.selectList(new QueryWrapper<Url>().lambda().in(Url::getUrl, strings));
            if(urlList1!=null && urlList1.size()>0){
               throw new CustomException(ResultCode.URL_IS_REPEATED);
            }
            List<Url> urls = new ArrayList<>();
            strings.forEach(s -> {
                Url url1 = new Url();
                url1.setUserId(url.getUserId());
                url1.setUrl(s);
                url1.setAccountType(url.getAccountType());
                url1.setUpdateTime(DateUtil.date());
                urls.add(url1);
            });
            this.saveBatch(urls);
            map.put("confName", url.getAccountType() == 0 ? CONFIG_NAME + url.getUserId() : CONFIG_ACCOUNT_NAME + url.getUserId());
        } else {
            throw new CustomException(ResultCode.URL_IS_REPEATED);
        }
        return map;
    }

    @Override
    public List<Url> selectList(Long userId){
        List<Url> urls = mapper.selectList(new LambdaQueryWrapper<Url>().eq(Url::getUserId, userId).select(Url::getUrl));
        return urls;
    }

}
