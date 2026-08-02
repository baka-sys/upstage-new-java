package com.aska.client.controller.auth;

import com.aska.common.model.ResponseData;
import com.aska.common.model.ResultCode;
import com.aska.common.model.Update;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.auth.IUrlService;
import com.aska.repository.domain.vo.UrlVO;
import com.aska.repository.entity.Url;
import freemarker.template.Template;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import freemarker.template.Configuration;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 域名表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-03-17
 */
@RestController
@RequestMapping("url")
public class UrlController {

    @Autowired
    IUrlService service;

    @Autowired
    Configuration freemarkerConfig;

    @PostMapping("save")
    @ApiOperation(value = "配置域名")
    public ResponseData saveAndUpdateByUrl(@RequestBody @Validated(Update.class) UrlVO vo) {
        Map<String,String> result = service.addAndUpdateByUrl(UrlVO.convert(vo));
        updateNginxConfig(result.get("domain"),result.get("confName"));
        return ResponseData.success();
    }


    private final static String CONF_PATH = "/usr/local/nginx/conf/vhost/";

    private void generateNginxConfig(String domain, String confName) throws Exception {
        Template template = freemarkerConfig.getTemplate("nginx-config.ftl");
        Map<String, Object> data = new HashMap<>();
        data.put("domain", domain);
//        data.put("backendHost", backendHost);
//        data.put("backendPort", backendPort);

        StringWriter writer = new StringWriter();
        template.process(data, writer);
        String configContent = writer.toString();

        // 写入Nginx配置目录（确保有权限）
        String filename = CONF_PATH + confName + ".conf";
        Files.write(Paths.get(filename), configContent.getBytes());
    }

    private boolean reloadNginx() throws IOException, InterruptedException {
        // 检查配置语法
        Process checkProcess = Runtime.getRuntime().exec("sudo /usr/local/nginx/sbin/nginx -t");
        int checkExitCode = checkProcess.waitFor();
        if (checkExitCode != 0) {
            // 读取错误信息
//            String errorMsg = new BufferedReader(new InputStreamReader(checkProcess.getErrorStream()))
//                    .lines().collect(Collectors.joining("\n"));
            throw new CustomException(ResultCode.NGINX_CONF_UPDATE_ERROR);
        }

        // 平滑重启
        Process reloadProcess = Runtime.getRuntime().exec("sudo /usr/local/nginx/sbin/nginx -s reload");
        int reloadExitCode = reloadProcess.waitFor();
        return reloadExitCode == 0;
    }

    private void updateNginxConfig(String domain,String confName) {
        try {
            generateNginxConfig(domain,confName);
            reloadNginx();
        } catch (Exception e) {
            // 删除无效配置并记录错误
            new File(CONF_PATH + confName + ".conf").delete();
            throw new CustomException(ResultCode.NGINX_CONF_UPDATE_ERROR);
        }
    }

}
