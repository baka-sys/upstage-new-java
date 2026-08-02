package com.aska;


import com.baomidou.mybatisplus.core.exceptions.MybatisPlusException;
import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.TemplateType;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import com.aska.common.util.StringUtils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Collections;
import java.util.Scanner;

public class SimpleCodeGenerator {
    //基础包名
    private static String basePackage="com.aska";
    //设置作者
    private static String authorName="sy";

    //数据库配置四要素
    private static String driverName = "com.mysql.cj.jdbc.Driver";
    private static String url = "jdbc:mysql://127.0.0.1/customer_system_browser?serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=utf-8";
    private static String username = "root";

    private static String password = "chat42";

    /**
     * <p>
     * 读取控制台内容
     * </p>
     */
    public static String scanner(String tip) {
        Scanner scanner = new Scanner(System.in);
        StringBuilder help = new StringBuilder();
        help.append("请输入" + tip + "：");
        System.out.println(help.toString());
        if (scanner.hasNext()) {
            String ipt = scanner.next();
            if (!StringUtils.isEmpty(ipt)) {
                return ipt;
            }
        }
        throw new MybatisPlusException("请输入正确的" + tip + "！");
    }
    public static void main(String[] args) {
        // 1.
        String moduleName = scanner("模块名");
        String twoLevelModuleName = scanner("二级目录");
        String[] tables = scanner("表名，多个英文逗号分割").split(",");
        //String modulePackageName = moduleName.substring(moduleName.indexOf("-") + 1);
        generateData(moduleName,twoLevelModuleName,tables);
        generateController(moduleName,twoLevelModuleName,tables);
        generateService(moduleName,twoLevelModuleName,tables);
    }

    /**
     * 生成service以及下面的实现类
     * @param moduleName
     * @param twoLevelModuleName
     * @param tables
     */
    private static void generateService(String moduleName,String twoLevelModuleName,String[] tables) {
        String projectPath = System.getProperty("user.dir");
        String dfOutputDir = projectPath + "/logical/src/main/java";
        String dfParentPack = basePackage;
        FastAutoGenerator.create(url,username,password)
                .globalConfig(builder -> {
                    builder.author(authorName)
                            .disableOpenDir()
                            .outputDir(dfOutputDir);
        }).packageConfig(builder -> {
            builder.parent(dfParentPack)
                    .entity("repository.entity")
                    .mapper("repository.mapper")
                    .service("logical.service."+twoLevelModuleName)
                    .serviceImpl("logical.service."+twoLevelModuleName+".impl");
        }).strategyConfig(builder -> {
            builder.addInclude(tables).addTablePrefix("cs_");
        }).templateConfig(builder -> {
            builder.disable(TemplateType.CONTROLLER,TemplateType.MAPPER,TemplateType.XML,TemplateType.ENTITY).build();
        }).templateEngine(new FreemarkerTemplateEngine()).execute();
    }

    /**
     * 生成对应的数据仓库
     * @param moduleName
     * @param twoLevelModuleName
     * @param tables
     */
    private static void generateController(String moduleName,String twoLevelModuleName, String[] tables) {
        String projectPath = System.getProperty("user.dir");
        String dfOutputDir = projectPath + "/"+moduleName+"/src/main/java";
        String dfParentPack = basePackage;
        FastAutoGenerator.create(url,username,password)
                .globalConfig(builder -> {
                    builder.author(authorName)
                            .disableOpenDir()
                            .enableSwagger()
                            .outputDir(dfOutputDir);
                }).packageConfig(builder -> {
                    builder.parent(dfParentPack)
                            .controller(moduleName +".controller."+twoLevelModuleName);
                }).strategyConfig(builder -> {
                    builder.addInclude(tables).addTablePrefix("cs_").controllerBuilder().enableRestStyle();
                }).templateConfig(builder -> {
                    builder.disable(TemplateType.MAPPER,TemplateType.XML,TemplateType.ENTITY,TemplateType.SERVICE,TemplateType.SERVICEIMPL).build();
                }).injectionConfig(builder -> {
                    builder.build();
                }).templateEngine(new FreemarkerTemplateEngine()).execute();
    }

    private static void generateData(String moduleName,String twoLevelModuleName, String[] tables) {
        String projectPath = System.getProperty("user.dir");
        String dfOutputDir = projectPath + "/repository/src/main/java";
        String dfParentPack = basePackage;
        FastAutoGenerator.create(url,username,password)
                .globalConfig(builder -> {
                    builder.author(authorName)
                            .disableOpenDir()
                            .outputDir(dfOutputDir);
                }).packageConfig(builder -> {
                    builder.parent(dfParentPack)
                            .entity("repository.entity")
                            .mapper("repository.mapper")
                            .pathInfo(Collections.singletonMap(OutputFile.xml, projectPath + "/repository/src/main/resources/mapper"));
                }).strategyConfig(builder -> {
                    builder.addInclude(tables).addTablePrefix("cs_").
                            mapperBuilder().enableMapperAnnotation().enableBaseResultMap().enableBaseColumnList().formatXmlFileName("%sXml")
                            .entityBuilder().enableLombok();
                }).templateConfig(builder -> {
                    builder.disable(TemplateType.CONTROLLER,TemplateType.SERVICE,TemplateType.SERVICEIMPL).build();
                }).injectionConfig(builder -> {
                    builder.build();
                }).templateEngine(new FreemarkerTemplateEngine()).execute();
         produceViewObject(dfOutputDir, dfParentPack, moduleName,twoLevelModuleName, true, tables);
         produceDataTransferObject(dfOutputDir, dfParentPack, moduleName,twoLevelModuleName, true, tables);
    }

    private static void produceViewObject(String dfOutPutDir,String dfParentPack,String moduleName,String twoLevelModuleName,boolean isTablePrefix, String... tableNames) {
        for (int i = 0; i < tableNames.length; i++) {
            String tableName = tableNames[i];
            tableName = isTablePrefix ? tableName.substring(tableName.indexOf("_") + 1) : tableName;
            String suPkStr = StringUtils.remove(tableName, "_").toLowerCase();
            String outPutDir = dfOutPutDir.replace("-data","") + "/" + (dfParentPack.replace(".", "/")) + "/repository/domain/vo/";
            String baseFileName = StringUtils.underline2Camel(tableName, false);
            try {
                File outFile = new File(outPutDir);
                if (!outFile.exists()) {
                    outFile.mkdirs();
                }
                File voFile = new File(outFile, baseFileName + "VO.java");
                if (!voFile.exists()) {
                    voFile.createNewFile();
                }
                BufferedReader reader = new BufferedReader(
                        new FileReader(dfOutPutDir + "/com/aska/repository/entity/" + baseFileName + ".java"));
                FileWriter fw = new FileWriter(voFile);
                String line = null;
                fw.write("package com.aska.repository.domain.vo;\r\n\r\n");
                fw.write("import com.aska.common.model.Update;\n" +
                        "import com.aska.repository.entity."+baseFileName + ";\r\n" +
                        "import io.swagger.annotations.ApiModel;\n" +
                        "import io.swagger.annotations.ApiModelProperty;\n" +
                        "import lombok.Data;\n" +
                        "import com.aska.common.util.BeanUtils;\n" +
                        "\n" +
                        "import javax.validation.constraints.NotBlank;\n" +
                        "import javax.validation.constraints.NotNull;\n" +
                        "import java.util.ArrayList;\n" +
                        "import java.util.List;\r\n" +
                        "import java.util.Date;\n");
                while ((line = reader.readLine()) != null) {

                    // 将实体类中的entity变为Vo
                    line = line.replace("entity", "vo").replace("Entity", "Vo");

                    if(line.contains("package")) {
                        continue;
                    }

                    if(line.contains("import")) {
                        continue;
                    }

                    // 文档注释
                    if(line.contains("/**")) {
                        continue;
                    }
                    if(line.contains("*/")) {
                        continue;
                    }
                    if(line.contains("     *")) {
                        fw.write("    @ApiModelProperty(value = \""+ line.replaceAll("\\*","").replaceAll(" ","")+"\")\r\n");
                        continue;
                    }

                    if(line.contains("@author")) {
                        fw.write("/**\r\n");
                        fw.write(" * @author " + authorName + "\r\n");
                        fw.write(" */\r\n");
                        continue;
                    }

                    if(line.contains("*")) {
                        continue;
                    }

                    // 去掉注解
                    if (line.contains("@")) {
                        continue;
                    }
                    // 类注解
                    if(line.startsWith("public")) {
                        fw.write("@Data\r\n");
                        fw.write("@ApiModel(value = \"\")\r\n");
                        fw.write("public class "+baseFileName+"VO {\r\n");
                        continue;
                    }

//                    // 去掉不需要的字段
//                    if (line.contains("createTime") || line.contains("updateTime") || line.contains("deleteOrNot")) {
//                        continue;
//                    }
                    // 去掉方法
                    if (line.contains("pkVal") || line.contains("return") || line.contains("}")) {
                        continue;
                    }
                    // 去掉一些
                    line += "\r\n";
                    fw.write(line);
                }
                fw.write("    @NotNull(groups = Update.class,message = \"主键不能为空\")\n");
                fw.write("    public static " +baseFileName+" convert(" + baseFileName + "VO vo) {\r\n" +
                        "        "+baseFileName+" entity = new "+baseFileName+"();\r\n" +
                        "        BeanUtils.copyProperties(vo,entity);\r\n" +
                        "        return entity;\r\n" +
                        "    }\r\n");
                fw.write("    public static List<"+baseFileName+"> convertList(List<"+baseFileName+"VO> list) {\r\n" +
                        "        List<"+baseFileName+"> resultList = new ArrayList<>();\r\n" +
                        "        for ("+baseFileName+"VO vo : list) {\r\n" +
                        "            resultList.add(convert(vo));\r\n" +
                        "        }\r\n" +
                        "        return resultList;\r\n" +
                        "    }\r\n");
                // 关闭类标签
                fw.write("}\r\n");
                fw.close();
                reader.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static void produceDataTransferObject(String dfOutPutDir,String dfParentPack,String moduleName,String twoLevelModuleName,boolean isTablePrefix, String... tableNames) {
        for (int i = 0; i < tableNames.length; i++) {
            String tableName = tableNames[i];
            tableName = isTablePrefix ? tableName.substring(tableName.indexOf("_") + 1) : tableName;
            String suPkStr = StringUtils.remove(tableName, "_").toLowerCase();
            String outPutDir = dfOutPutDir.replace("-data","") + "/" + (dfParentPack.replace(".", "/")) + "/repository/domain/dto/";
            String baseFileName = StringUtils.underline2Camel(tableName, false);
            try {
                File outFile = new File(outPutDir);
                if (!outFile.exists()) {
                    outFile.mkdirs();
                }
                File dtoFile = new File(outFile, baseFileName + "DTO.java");
                if (!dtoFile.exists()) {
                    dtoFile.createNewFile();
                }
                BufferedReader reader = new BufferedReader(
                        new FileReader(dfOutPutDir + "/com/aska/repository/entity/" +baseFileName + ".java"));
                FileWriter fw = new FileWriter(dtoFile);
                String line = null;
                fw.write("package com.aska.repository.domain.dto;\r\n\r\n");
                fw.write("" +
                        "import com.aska.repository.entity."+ baseFileName + ";\r\n" +
                        "import lombok.Data;\n" +
                        "import io.swagger.annotations.ApiModel;\n" +
                        "import io.swagger.annotations.ApiModelProperty;\n" +
                        "import com.fasterxml.jackson.annotation.JsonInclude;\n" +
                        "import com.aska.common.util.BeanUtils;\n" +
                        "\n" +
                        "import java.util.ArrayList;\n" +
                        "import java.util.List;\r\n" +
                        "import java.util.Date;\n");
                while ((line = reader.readLine()) != null) {
                    // 将实体类中的entity变为Vo
                    line = line.replace("entity", "dto").replace("Entity", "dto");

                    if(line.contains("package")) {
                        continue;
                    }

                    if(line.contains("import")) {
                        continue;
                    }
                    // 文档注释
                    if(line.contains("/**")) {
                        continue;
                    }
                    if(line.contains("*/")) {
                        continue;
                    }
                    if(line.contains("     *")) {
                        fw.write("    @ApiModelProperty(value = \""+ line.replaceAll("\\*","").replaceAll(" ","")+"\")\r\n");
                        continue;
                    }

                    if(line.contains("@author")) {
                        fw.write("/**\r\n");
                        fw.write(" * @author " + authorName + "\r\n");
                        fw.write(" */\r\n");
                        continue;
                    }

                    if(line.contains("*")) {
                        continue;
                    }

                    // 去掉注解
                    if (line.contains("@")) {
                        continue;
                    }

                    // 类注解
                    if(line.startsWith("public")) {
                        fw.write("@Data\r\n");
                        fw.write("@JsonInclude(JsonInclude.Include.NON_NULL)\r\n");
                        fw.write("public class "+baseFileName+"DTO {\r\n");
                        continue;
                    }
//                    // 去掉不需要的字段
//                    if (line.contains("createTime") || line.contains("updateTime") || line.contains("deleteOrNot")) {
//                        continue;
//                    }
                    // 去掉方法
                    if (line.contains("pkVal") || line.contains("return") || line.contains("}")) {
                        continue;
                    }
                    // 去掉一些
                    line += "\r\n";
                    fw.write(line);
                }
                fw.write("    public "+ baseFileName +"DTO() {}\n" +
                        "\n" +
                        "    public "+ baseFileName +"DTO("+ baseFileName +" entity) {\n" +
                        "        BeanUtils.copyProperties(entity,this);\n" +
                        "    }\n" +
                        "\n" +
                        "    public static "+ baseFileName +"DTO convert("+ baseFileName +" entity) {\n" +
                        "        return new "+ baseFileName +"DTO(entity);\n" +
                        "    }\n" +
                        "\n" +
                        "    public static List<"+ baseFileName +"DTO> convertList(List<"+ baseFileName +"> list) {\n" +
                        "        List<"+ baseFileName +"DTO> resultList = new ArrayList<>();\n" +
                        "        for ("+ baseFileName +" entity : list) {\n" +
                        "            resultList.add(new "+ baseFileName +"DTO(entity));\n" +
                        "        }\n" +
                        "        return resultList;\n" +
                        "    }");
                // 关闭类标签
                fw.write("}\r\n");
                fw.close();
                reader.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}

