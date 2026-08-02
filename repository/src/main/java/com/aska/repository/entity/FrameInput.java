package com.aska.repository.entity;


import lombok.Data;

import java.util.List;

@Data
public class FrameInput {

    private String type;

    private String title;

    private String field;

    private Object value;

    private Object props;

    private List<Options> options;
}
