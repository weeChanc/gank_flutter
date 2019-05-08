package com.example.gank_flutter;

import android.content.Intent;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), PREFIX + "/web")
                .setMethodCallHandler((methodCall, result) -> {
                    switch (methodCall.method) {
                        case Md.START_WEB_VIEW:
                            String url = (String) methodCall.arguments;
                            Intent intent = new Intent(this, WebActivity.class);
                            intent.putExtra("url",url);
                            startActivity(intent);
                            result.success(1);
                            return;
                    }
                    result.error("method not match", null, null);
                });
    }

    public static String PREFIX = "gank.flutter";

    static class Md {
        final static String START_WEB_VIEW = "startWebView";
    }
}


