package com.aska.common.model;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ResponseData<T> {

    public static final String DEFAULT_SUCCESS_MESSAGE = "成功";

    public static final String DEFAULT_ERROR_MESSAGE = "网络错误";

    public static final Integer DEFAULT_SUCCESS_CODE = 200;

    public static final Integer DEFAULT_ERROR_CODE = 401;

    /**
     * 请求是否成功
     */
    private Boolean success;

    /**
     * 响应状态码
     */
    private Integer code;

    /**
     * 响应信息
     */
    private String message;

    /**
     * 响应对象
     */
    private T data;

    /**
     * 分页总数
     */
    private Long total;

    public ResponseData() {

    }

    public ResponseData(Boolean success, Integer code, String message, T data, Long totals) {
        this.success = success;
        this.code = code;
        this.message = message;
        this.data = data;
        this.total = totals;
    }

    //=================================成功返回==================================

    public static <T> ResponseData<T> success() {
        return new ResponseData<T>(true, DEFAULT_SUCCESS_CODE, DEFAULT_SUCCESS_MESSAGE, null,0L);
    }

    public static <T> ResponseData<T> success(T object) {
        return new ResponseData<T>(true, DEFAULT_SUCCESS_CODE, DEFAULT_SUCCESS_MESSAGE, object,0L);
    }

    public static <T> ResponseData<T> success(String message, T object) {
        return new ResponseData<T>(true, DEFAULT_SUCCESS_CODE, message, object,0L);
    }

    public static <T> ResponseData<T> success(T object,Long total) {
        return new ResponseData<T>(true, DEFAULT_SUCCESS_CODE, null, object,total);
    }

    //=================================失败返回==================================

    public static <T> ResponseData<T> error() {
        return new ResponseData<T>(false, ResponseData.DEFAULT_ERROR_CODE, DEFAULT_ERROR_MESSAGE, null,0L);
    }

    public static <T> ResponseData<T> error(String message) {
        return new ResponseData<T>(false, ResponseData.DEFAULT_ERROR_CODE, message, null,0L);
    }

    public static <T> ResponseData<T> error(Integer code, String message) {
        return new ResponseData<T>(false, code, message, null,0L);
    }

    public static <T> ResponseData<T> error(Integer code, String message, T object) {
        return new <T>ResponseData<T>(false, code, message, object,0L);
    }
}
