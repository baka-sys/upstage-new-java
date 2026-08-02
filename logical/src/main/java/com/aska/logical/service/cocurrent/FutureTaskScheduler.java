package com.aska.logical.service.cocurrent;

import com.aska.common.util.ThreadUtil;

import java.util.concurrent.ThreadPoolExecutor;

public class FutureTaskScheduler {
    static ThreadPoolExecutor mixPool = null;

    static {
        mixPool = ThreadUtil.getMixedTargetThreadPool();
    }

    private FutureTaskScheduler(){

    }

    /**
     * 添加任务
     * @param executeTask
     */
    public static void add(Runnable executeTask) {
        mixPool.submit(()->{ executeTask.run(); });
    }
}
