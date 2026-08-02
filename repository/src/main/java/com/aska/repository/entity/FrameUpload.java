package com.aska.repository.entity;


import lombok.Data;

import java.util.List;

@Data
public class FrameUpload {

    private String type;

    private String field;

    private String title;

    private List<String> value;
}
