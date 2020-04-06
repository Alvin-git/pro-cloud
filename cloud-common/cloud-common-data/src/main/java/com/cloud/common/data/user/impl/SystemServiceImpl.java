package com.cloud.common.data.user.impl;

import com.cloud.common.data.user.SystemService;

/**
 * 默认用户信息
 * @author Aijm
 * @since 2019/8/25
 */
public class SystemServiceImpl implements SystemService {


    /**
     * 获取到登录用户的id 为了封装
     *
     * @return
     */
    @Override
    public Long getUserId() {
        return 1L;
    }

    /**
     * 获取到用户的id集合
     *
     * @return
     */
    @Override
    public String getUserTenantIds() {
        return null;
    }


}
