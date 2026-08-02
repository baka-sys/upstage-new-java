package com.aska.upstage.config.exception;

import com.aska.common.model.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import javax.validation.ConstraintViolationException;
import javax.validation.ValidationException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author ：songyu
 * @date ：Created in 2020/11/9 15:47
 * @description：全局异常处理类
 * @modified By：
 * @version: 1.0$
 *
 *
 * modify by sy
 * 统一异常处理返回message替代msg
 * 2021-3-12
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {
    /**
     * 处理CustomException
     *
     * @param e exception
     * @return 响应结果
     */
    @ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler({CustomException.class})
    public Map<String, Object> customExceptionHandler(final Exception e) {
        CustomException exception = (CustomException) e;
        if (exception.getStackTrace().length > 0) {
            log.error(e.getClass().getName() + "---{}",e.getMessage());
        }
        Map<String, Object> resultMap = new HashMap<String,Object>(4);
        resultMap.put("code", exception.getCode());
        resultMap.put("message", exception.getMessage());
        return resultMap;
    }

    /**
     * 处理NulldragonerException
     *
     * @param e exception
     * @return 响应结果
     */
    @ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(NullPointerException.class)
    public Map<String, Object> nullPointerExceptionHandler(final Exception e) {
        NullPointerException exception = (NullPointerException) e;
        if (exception.getStackTrace().length > 0) {
            log.error(e.getClass().getName() + "---{}",e.getMessage());
            e.printStackTrace();
//            StackTraceElement stackTraceElement = exception.getStackTrace()[0];
//            printlnLog("NullPointerException", stackTraceElement);
        }

        Map<String, Object> resultMap = new HashMap<String, Object>(4);
        resultMap.put("code", "50001");
        resultMap.put("message", "NullPointerException");

        return resultMap;
    }


    /**
     * 处理Validated校验异常
     * 注:常见的ConstraintViolationException异常，也属于ValidationException异常
     *
     * @param e 捕获到的异常
     * @return 返回给前端的data
     */
    @ResponseStatus(code = HttpStatus.BAD_REQUEST)
    @ExceptionHandler(value = {BindException.class, ValidationException.class, MethodArgumentNotValidException.class, MissingServletRequestParameterException.class})
    public Map<String, Object> handleParameterVerificationException(final Exception e) {
        Map<String, Object> resultMap = new HashMap<String, Object>(4);
        resultMap.put("code", "40001");
        StringBuilder builder = new StringBuilder();

        // BindException
        if (e instanceof BindException) {
            if (e.getStackTrace().length > 0) {
                log.error(e.getClass().getName() + "---{}",e.getMessage());
//                StackTraceElement stackTraceElement = e.getStackTrace()[0];
//                printlnLog("BindException", stackTraceElement);
            }

            // getFieldError获取的是第一个不合法的参数(P.S.如果有多个参数不合法的话)
            FieldError fieldError = ((BindException) e).getFieldError();
            if (fieldError != null) {
                builder.append(fieldError.getField()).append(":");
                builder.append(fieldError.getDefaultMessage());
            }

            // MethodArgumentNotValidException
        } else if (e instanceof MethodArgumentNotValidException) {
            if (e.getStackTrace().length > 0) {
                log.error(e.getClass().getName() + "---{}",e.getMessage());
//                StackTraceElement stackTraceElement = e.getStackTrace()[0];
//                printlnLog("MethodArgumentNotValidException", stackTraceElement);
            }

            BindingResult bindingResult = ((MethodArgumentNotValidException) e).getBindingResult();
            FieldError fieldError = bindingResult.getFieldError();
            if (fieldError != null) {
                builder.append(fieldError.getField()).append(":");
                builder.append(fieldError.getDefaultMessage());
            }

            // ValidationException的子类异常ConstraintViolationException
        } else if (e instanceof ConstraintViolationException) {
            if (e.getStackTrace().length > 0) {
                log.error(e.getClass().getName() + "---{}",e.getMessage());
//                StackTraceElement stackTraceElement = e.getStackTrace()[0];
//                printlnLog("ConstraintViolationException", stackTraceElement);
            }

            /*
             * ConstraintViolationException的e.getMessage()形如:{方法名}.{参数名}: {message}
             * 这里只需要取后面的message即可
             */
            String msg = e.getMessage();
            if (msg != null) {
                int lastIndex = msg.lastIndexOf('.');
                if (lastIndex >= 0) {
                    msg = msg.substring(lastIndex + 1).trim();
                    builder.append(msg);
                }
            }

            // 处理MissingServletRequestParameterException异常
        } else if (e instanceof MissingServletRequestParameterException) {
            log.error(e.getClass().getName() + "---{}",e.getMessage());
            String type = ((MissingServletRequestParameterException) e).getParameterType();
            String name = ((MissingServletRequestParameterException) e).getParameterName();
            builder.append("参数type={").append(type).append("}name={").append(name).append("}缺失");
            // ValidationException 的其它子类异常
        } else {
            builder.append("处理参数时异常");
        }

        resultMap.put("message", builder.toString());
        return resultMap;
    }

    /**
     * 处理其他异常
     *
     * @param e exception
     * @return 响应结果
     */
    @ResponseStatus(code = HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(Exception.class)
    public Map<String, Object> exceptionHandler(final Exception e) {
        if (e.getStackTrace().length > 0) {
            log.error(e.getClass().getName() + "---{}",e.getMessage());
            e.printStackTrace();
//            StackTraceElement stackTraceElement = e.getStackTrace()[0];
//            printlnLog("Exception", stackTraceElement);
        }
        Map<String, Object> resultMap = new HashMap<String, Object>(4);
        resultMap.put("code", "50010");
        resultMap.put("message", "服务异常");
        return resultMap;
    }

    /**
     * 打印错误信息
     *
     * @param name              异常名称
     * @param stackTraceElement 错误信息
     */
    private void printlnLog(String name, StackTraceElement stackTraceElement) {
        log.error(name +
                "->类名：" + stackTraceElement.getFileName() +
                " ->错误代码行：" + stackTraceElement.getLineNumber() +
                " ->路径：" + stackTraceElement.getClassName());
    }
}

