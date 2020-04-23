package com.cloud.common.util.var;

import com.cloud.common.util.client.CloudServiceList;
import lombok.experimental.UtilityClass;

/**
 * @Author Aijm
 * @Description 静态常用数据
 * @Date 2019/7/23
 */
@UtilityClass
public class StaticVar {


    /**
     * 获取token的地址
     */
    public static final String LOGIN_URL = "http://"+ CloudServiceList.CLOUD_AUTH+ "/oauth/token";

    /**
     * head 放入的tenant
     */
    public static final String TENANT_ID = "user_tenant";

    /**
     * 默认的租户值
     */
    public static final String TENANT_ID_DEFAULT = "0";

}
