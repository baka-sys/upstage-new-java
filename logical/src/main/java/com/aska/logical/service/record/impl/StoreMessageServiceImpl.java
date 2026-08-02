package com.aska.logical.service.record.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.logical.service.record.StoreMessageService;
import com.aska.repository.entity.ChatRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;

@Service
public class StoreMessageServiceImpl implements StoreMessageService {

    @Autowired
    MongoTemplate mongoTemplate;


    /**
     * 删除聊天记录
     */
    @Override
    public void deleteChatHistory(){
        Long time = DateUtil.offsetDay(DateUtil.date(), -1).getTime();
        Query query = new Query();
        query.addCriteria(new Criteria().where("time").lt(time));
        mongoTemplate.remove(query, ChatRecord.class);
    }
}
