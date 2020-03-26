package com.cloud.common.security.util;

import com.cloud.common.security.component.SecurityUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * @Author Aijm
 * @Description 根据SecurityContext 获取信息
 * @Date 2020/3/26
 */
public class SecurityUtil {

    /**
     * 获取SecurityUser
     * @return
     */
    public static SecurityUser getSecurityUser(){
        SecurityContext context = SecurityContextHolder.getContext();
        Authentication authentication = context.getAuthentication();
        return (SecurityUser)authentication.getPrincipal();
    }

    /**
     * 获取登录用户的信息
     * @return
     */
    public static Long getUserId(){
        return getSecurityUser().getUserId();
    }


    /**
     * 获取登录用户的信息 登录名
     * @return
     */
    public static String getUserName(){
        return getSecurityUser().getUsername();
    }
}
