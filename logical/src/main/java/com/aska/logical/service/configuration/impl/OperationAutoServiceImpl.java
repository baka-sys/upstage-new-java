package com.aska.logical.service.configuration.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.aska.common.util.RedisUtil;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.repository.entity.FrameInput;
import com.aska.repository.entity.OperationAuto;
import com.aska.repository.entity.Options;
import com.aska.repository.mapper.OperationAutoMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
@Service
public class OperationAutoServiceImpl extends ServiceImpl<OperationAutoMapper, OperationAuto> implements IOperationAutoService {


    private final static String SYSTEM_SETTINGS = "SYSTEM_SETTINGS";

    private final static String SYSTEM_REDIS = "system_redis";

    @Autowired
    OperationAutoMapper autoMapper;

    @Autowired
    RedisUtil redisUtil;

    @Override
    public Integer addAuto(OperationAuto convert) {
        convert.setCreateTime(DateUtil.date());
        autoMapper.insert(convert);
        return convert.getId();
    }

    @Override
    public void updateAuto(OperationAuto convert){
        convert.setUpdateTime(DateUtil.date());
        autoMapper.updateById(convert);
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void updateOne(HashMap hashMap){
        QueryWrapper<OperationAuto> queryWrapper = new QueryWrapper<>();
        OperationAuto operationAuto = new OperationAuto();
        hashMap.forEach((key,value)->{
            queryWrapper.clear();
            queryWrapper.lambda().eq(OperationAuto::getField,key);
            operationAuto.setValue(String.valueOf(value));
            autoMapper.update(operationAuto,queryWrapper);
        });
        redisUtil.delete(SYSTEM_REDIS);
    }

    @Override
    public void deleteAuto(Integer id){
        autoMapper.deleteById(id);
    }

    @Override
    public OperationAuto selectDetailBySystemCode(String field) {
        QueryWrapper<OperationAuto> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(OperationAuto::getField,field);
        OperationAuto operationAuto = autoMapper.selectOne(wrapper);
        return operationAuto;
    }

    @Override
    public List<Object> selectDetailByCode(Integer codeType, HttpServletRequest request){
        String token = request.getHeader("Authorization");
        String refreshToken = request.getHeader("RefreshToken");
        List<Object> jsonObjects = new ArrayList<>();
        QueryWrapper<OperationAuto> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(OperationAuto::getCodeType, codeType);
        List<OperationAuto> list = autoMapper.selectList(queryWrapper);
        list.forEach(operationAuto -> {
            jsonObjects.add(switchTypeBy(operationAuto.getType(),operationAuto,token, refreshToken));
        });
        return jsonObjects;
    }


    private Object switchTypeBy(Integer type,OperationAuto operationAuto,String tokens, String refreshTokens){
        Object object = new Object();
        switch (type){
            case 1:
                FrameInput frameInput = new FrameInput();
                frameInput.setType("input");
                frameInput.setTitle(operationAuto.getTitle());
                frameInput.setField(operationAuto.getField());
                frameInput.setValue(operationAuto.getValue());
                object = frameInput;
                break;
            case 2:
                FrameInput frameInput1 = new FrameInput();
                frameInput1.setType("textarea");
                frameInput1.setTitle(operationAuto.getTitle());
                frameInput1.setField(operationAuto.getField());
                frameInput1.setValue(operationAuto.getValue());
                object = frameInput1;
                break;
            case 3:
                FrameInput frameInput2 = new FrameInput();
                frameInput2.setType("radio");
                frameInput2.setTitle(operationAuto.getTitle());
                frameInput2.setField(operationAuto.getField());
                frameInput2.setValue(operationAuto.getValue());
                //组装option
                if(StrUtil.isNotBlank(operationAuto.getDefValue())){
                    List<Options> optionsList = new ArrayList<>();
                    List<String> optionF = Arrays.asList(operationAuto.getDefValue().split(","));
                    optionF.forEach(operationString->{
                        String[] strings = operationString.split(" ");
                        optionsList.add(new Options(strings[1],strings[0]));
                    });
                    frameInput2.setOptions(optionsList);
                }
                object = frameInput2;
                break;
            case 4:
                FrameInput frameInput3 = new FrameInput();
                frameInput3.setType("checkbox");
                frameInput3.setTitle(operationAuto.getTitle());
                frameInput3.setField(operationAuto.getField());
                frameInput3.setValue(operationAuto.getValue().split(","));
                //组装option
                if(StrUtil.isNotBlank(operationAuto.getDefValue())){
                    List<Options> optionsList = new ArrayList<>();
                    List<String> optionF = Arrays.asList(operationAuto.getDefValue().split(","));
                    optionF.forEach(operationString->{
                        String[] strings = operationString.split(" ");
                        optionsList.add(new Options(strings[1],strings[0]));
                    });
                    frameInput3.setOptions(optionsList);
                }
                object = frameInput3;
                break;
            case 5:
                FrameInput frameInput4 = new FrameInput();
                frameInput4.setType("select");
                frameInput4.setTitle(operationAuto.getTitle());
                frameInput4.setField(operationAuto.getField());
                frameInput4.setValue(JSONUtil.toJsonStr(operationAuto.getValue().split(",")));
                //组装option
                if(StrUtil.isNotBlank(operationAuto.getDefValue())){
                    List<Options> optionsList = new ArrayList<>();
                    List<String> optionF = Arrays.asList(operationAuto.getDefValue().split(","));
                    optionF.forEach(operationString->{
                        String[] strings = operationString.split(" ");
                        optionsList.add(new Options(strings[1],strings[0]));
                    });
                    frameInput4.setOptions(optionsList);
                }
                object = frameInput4;
                break;
            case 6:
                FrameInput frameInput5 = new FrameInput();
                Map<String,String> props = new HashMap<>();
                props.put("multiple","true");
                frameInput5.setType("select");
                frameInput5.setTitle(operationAuto.getTitle());
                frameInput5.setField(operationAuto.getField());
                frameInput5.setValue(JSONUtil.toJsonStr(operationAuto.getValue().split(",")));
                frameInput5.setProps(props);
                //组装option
                if(StrUtil.isNotBlank(operationAuto.getDefValue())){
                    List<Options> optionsList = new ArrayList<>();
                    List<String> optionF = Arrays.asList(operationAuto.getDefValue().split(","));
                    optionF.forEach(operationString->{
                        String[] strings = operationString.split(" ");
                        optionsList.add(new Options(strings[1],strings[0]));
                    });
                    frameInput5.setOptions(optionsList);
                }
                object = frameInput5;
                break;
            case 7:
                FrameInput frameInput6 = new FrameInput();
                Map<String,String> prop = new HashMap<>();
                prop.put("activeValue","1");
                prop.put("inactiveValue","0");
                frameInput6.setType("switch");
                frameInput6.setTitle(operationAuto.getTitle());
                frameInput6.setField(operationAuto.getField());
                frameInput6.setValue(operationAuto.getValue());
                frameInput6.setProps(prop);
                object = frameInput6;
                break;
            case 8:
                FrameInput frameInput7 = new FrameInput();
                Map<String,Object> props1 = new HashMap<>();
                Map<String,Object> token = new HashMap<>();
                token.put("Authorization",tokens);
                token.put("refreshToken",refreshTokens);
                props1.put("uploadType","image");
                props1.put("action","/other/uploadImg");
                props1.put("headers",token);
                props1.put("accept","image\\/");
                props1.put("onSuccess","function (res, file) {" +
                        "            file.url = res.data.filePath;" +
                        "        }");
                props1.put("type","select");
                props1.put("multiple","false");
                props1.put("limit",1);
                frameInput7.setType("upload");
                frameInput7.setTitle(operationAuto.getTitle());
                frameInput7.setField(operationAuto.getField());
                frameInput7.setValue(operationAuto.getValue());
                frameInput7.setProps(props1);
                object = frameInput7;
                break;
        }
        return  object;
    }

    @Override
    public List<OperationAuto> selectAllSystem(){
        QueryWrapper<OperationAuto> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().select(OperationAuto::getField,OperationAuto::getValue,OperationAuto::getId);
        List<OperationAuto> result = autoMapper.selectList(queryWrapper);
        return result;
    }

    @Override
    public String selectRedisValueByFiled(String field){
        Object object = redisUtil.get(SYSTEM_SETTINGS);
        List<OperationAuto> operationAutos;
        if(object == null){
            // 查询所有配置项
            operationAutos = selectAllSystem();
            redisUtil.set(SYSTEM_SETTINGS, JSONUtil.toJsonStr(operationAutos));
        } else {
            operationAutos = JSON.parseObject(object.toString(),new TypeReference<List<OperationAuto>>(){});
        }
        OperationAuto operationAuto = operationAutos.stream().filter(o->o.getField().equals(field)).findFirst().get();
        return operationAuto.getValue();
    }

    @Override
    public void cleanRedisConfig(){
        redisUtil.del(SYSTEM_SETTINGS);
    }

}
