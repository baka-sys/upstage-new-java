package com.aska.upstage.config.swagger;


import com.google.common.collect.Lists;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.env.Profiles;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.*;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.*;

@Configuration
@EnableSwagger2
@ConditionalOnClass({Docket.class, ApiInfoBuilder.class})
@ConditionalOnProperty(prefix = "swagger",value = "enable",matchIfMissing = true)
@EnableConfigurationProperties(SwaggerProperties.class)
public class SwaggerConfig implements BeanFactoryAware {
    private BeanFactory beanFactory;

    @Autowired
    private SwaggerProperties swaggerProperties;


    @Bean
    public List<Docket> createRestApi(Environment environment) {
        // 设置要显示swagger的环境
        Profiles of = Profiles.of("test","dev");
        // 判断当前是否处于该环境
        // 通过 enable() 接收此参数判断是否要显示
        boolean useFlag = environment.acceptsProfiles(of);
        // boolean useFlag = false;

        ConfigurableBeanFactory configurableBeanFactory = (ConfigurableBeanFactory) beanFactory;
        List<Docket> docketList = new LinkedList<Docket>();

        Map<String, SwaggerProperties.DocketInfo> docketInfos = swaggerProperties.getDocket();
        for (String groupName : docketInfos.keySet()) {
            SwaggerProperties.DocketInfo docketInfo = docketInfos.get(groupName);

            Contact contact = new Contact(
                    docketInfo.getApiInfo().getContact().getName(),
                    docketInfo.getApiInfo().getContact().getUrl(),
                    docketInfo.getApiInfo().getContact().getEmail());

            ApiInfo apiInfo = new ApiInfoBuilder()
                    .title(docketInfo.getApiInfo().getTitle())
                    .description(docketInfo.getApiInfo().getDescription())
                    .version(docketInfo.getApiInfo().getVersion())
                    .contact(contact)
                    .build();

            Docket docket = new Docket(DocumentationType.SWAGGER_12)
                    .enable(useFlag)
                    .useDefaultResponseMessages(false)
                    .select()
                    .apis(RequestHandlerSelectors.basePackage(docketInfo.getBasePackage()))
                    .build()
                    .securitySchemes(securitySchemes())
                    .securityContexts(securityContexts())
                    .apiInfo(apiInfo)
                    .groupName(groupName);
            configurableBeanFactory.registerSingleton(groupName, docket);
            docketList.add(docket);
        }
        return docketList;
    }


    List<SecurityReference> defaultAuth() {
        AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
        AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
        authorizationScopes[0] = authorizationScope;
        return Lists.newArrayList(
                new SecurityReference(swaggerProperties.getAuthorization().getKeyName(), authorizationScopes),
                new SecurityReference("refreshToken", authorizationScopes)
        );
//        return new ArrayList(
//                Collections.singleton(new SecurityReference(swaggerProperties.getAuthorization().getKeyName(), authorizationScopes))
//        );
    }

    private List<ApiKey> securitySchemes() {
        return Lists.newArrayList(
                new ApiKey(swaggerProperties.getAuthorization().getName(), swaggerProperties.getAuthorization().getKeyName(), "header"),
                new ApiKey("refreshToken", "refreshToken", "header")
                );
//        return new ArrayList(
//                Collections.singleton(new ApiKey(swaggerProperties.getAuthorization().getName(), swaggerProperties.getAuthorization().getKeyName(), "header"));
    }

    private List<SecurityContext> securityContexts() {
        return new ArrayList(
                Collections.singleton(SecurityContext.builder()
                        .securityReferences(defaultAuth())
                        .forPaths(PathSelectors.regex(swaggerProperties.getAuthorization().getAuthRegex()))
                        .build())
        );
    }

    @Override
    public void setBeanFactory(BeanFactory beanFactory) throws BeansException {
        this.beanFactory = beanFactory;
    }

}
