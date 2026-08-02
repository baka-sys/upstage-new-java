package com.aska.common.model.exception;

import com.aska.common.model.ResultCode;
import lombok.Getter;

import java.io.Serializable;

public class CustomException extends RuntimeException implements Serializable {

    @Getter
    private int code;

    @Getter
    private String message;

    public CustomException(String message) {
        super(message);
    }

    public CustomException(String message, Throwable cause) {
        super(message, cause);
    }

    public CustomException(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public CustomException(ResultCode resultCode) {
        this.code = resultCode.code();
        this.message = resultCode.message();
    }
}
