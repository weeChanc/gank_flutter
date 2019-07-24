package com.example.gank_flutter;

import android.content.Intent;
import android.os.Bundle;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterActivity;

import java.lang.ref.SoftReference;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainFlutterActivity extends BoostFlutterActivity {

    public static WeakReference<MainFlutterActivity> sRef;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        sRef = new WeakReference<>(this);

        new MethodChannel(getFlutterView(), PREFIX + "/web")
                .setMethodCallHandler((methodCall, result) -> {
                    switch (methodCall.method) {
                        case Md.START_WEB_VIEW:
                            String url = (String) methodCall.arguments;
                            Intent intent = new Intent(this, WebActivity.class);
                            intent.putExtra("url", url);
                            startActivity(intent);
                            result.success(1);
                            return;
                    }
                    result.error("method not match", null, null);
                });


    }

    @Override
    public String getContainerName() {
        return "flutter_main";
    }


    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    public static String PREFIX = "gank.flutter";

    static class Md {
        final static String START_WEB_VIEW = "startWebView";
    }

    @Override
    public Map getContainerParams() {
        Map<String, String> params = new HashMap<>();
        params.put("aaa", "bbb");
        return params;
    }
}


