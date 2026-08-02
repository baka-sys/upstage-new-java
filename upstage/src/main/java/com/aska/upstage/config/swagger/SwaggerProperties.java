package com.aska.upstage.config.swagger;


import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.LinkedHashMap;
import java.util.Map;

@ConfigurationProperties(prefix = "swagger")
@Data
public class SwaggerProperties {
    /**
     * 分组文档
     **/
    private Map<String, DocketInfo> docket = new LinkedHashMap<String, DocketInfo>();

    @Data
    @NoArgsConstructor
    public static class DocketInfo {
        /**
         * 联系人信息
         **/
        private ApiInfo apiInfo = new ApiInfo();

        /**
         * swagger会解析的包路径
         **/
        private String basePackage;
    }


    @Data
    @NoArgsConstructor
    public static class ApiInfo {
        /**
         * 标题
         **/
        private String title = "";

        /**
         * 描述
         **/
        private String description = "";

        /**
         * 版本
         **/
        private String version = "";

        /**
         * 联系人信息
         **/
        private Contact contact = new Contact();
    }

    @Data
    @NoArgsConstructor
    public static class Contact {
        /**
         * 联系人姓名
         **/
        private String name = "";

        /**
         * 联系人url
         **/
        private String url = "";

        /**
         * 联系人email
         **/
        private String email = "";
    }

    /**
     * 全局统一鉴权配置
     **/
    private Authorization authorization = new Authorization();

    /**
     * 刷新token
     */
//    private Refresh refresh = new Refresh();

    /**
     * securitySchemes 支持方式之一 ApiKey
     */
    @Data
    @NoArgsConstructor
    static class Authorization {

        /**
         * 鉴权策略ID，对应 SecurityReferences ID
         */
        private String name = "Authorization";

        /**
         * 鉴权传递的Header参数
         */
        private String keyName = "token";

        /**
         * 需要开启鉴权URL的正则
         */
        private String authRegex = "^.*$";
    }

//    @Data
//    @NoArgsConstructor
//    static class Refresh {
//        /**
//         * 刷新token名称
//         */
//        private String name = "RefreshToken";
//
//        private String keyName = "refreshToken";
//
//        private String authRegex = "^.*$";
//    }
}
