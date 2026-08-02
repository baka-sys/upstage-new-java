package com.aska.repository.entity;


import lombok.Data;

import java.util.List;

@Data
public class FrameRadio {

    private String type;

    private String title;

    private String field;

    private String value;

    private List options;
}
