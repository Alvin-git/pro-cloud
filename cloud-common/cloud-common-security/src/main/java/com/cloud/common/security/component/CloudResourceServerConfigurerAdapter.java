package com.cloud.common.security.component;


import com.cloud.common.security.exception.AuthExceptionEntryPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.security.oauth2.OAuth2ClientProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableResourceServer;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.DefaultAccessTokenConverter;
import org.springframework.web.client.RestTemplate;

/**
 * @Author Aijm
 * @Description 资源服务器
 * @Date 2019/5/8
 */
@Configuration
@EnableResourceServer
@EnableGlobalMethodSecurity(prePostEnabled = true, securedEnabled = true, jsr250Enabled = true)
public class CloudResourceServerConfigurerAdapter extends ResourceServerConfigurerAdapter {

    @Value("${security.oauth2.resource.token-info-uri}")
    private String checkTokenEndpointUrl;

    private static final String DEMO_RESOURCE_ID = "admin";

    @Autowired
    private OAuth2ClientProperties oAuth2ClientProperties;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private ProUserAuthenticationConverter proUserAuthenticationConverter;

    @Autowired
    private AuthExceptionEntryPoint authExceptionEntryPoint;

    @Autowired
    private PermitProps permitAllUrlProps;


    @Override
    public void configure(ResourceServerSecurityConfigurer resources) throws Exception {
        DefaultAccessTokenConverter accessTokenConverter = new DefaultAccessTokenConverter();
        accessTokenConverter.setUserTokenConverter(proUserAuthenticationConverter);

        RemoteTokenServices remoteTokenServices = new RemoteTokenServices();
        remoteTokenServices.setClientId(oAuth2ClientProperties.getClientId());
        remoteTokenServices.setClientSecret(oAuth2ClientProperties.getClientSecret());
        remoteTokenServices.setCheckTokenEndpointUrl(checkTokenEndpointUrl);
        remoteTokenServices.setAccessTokenConverter(accessTokenConverter);
        remoteTokenServices.setRestTemplate(restTemplate);
        resources.tokenServices(remoteTokenServices);
        resources.authenticationEntryPoint(authExceptionEntryPoint);
        resources.resourceId(DEMO_RESOURCE_ID);
        super.configure(resources);
    }


    @Override
    public void configure(HttpSecurity http) throws Exception {
        http.headers().frameOptions().disable();
        ExpressionUrlAuthorizationConfigurer<HttpSecurity>
                .ExpressionInterceptUrlRegistry registry = http
                .authorizeRequests();
        permitAllUrlProps.getIgnoreUrls()
                .forEach(url -> registry.antMatchers(url).permitAll());
        registry.anyRequest().authenticated()
                .and().csrf().disable();
    }
}
