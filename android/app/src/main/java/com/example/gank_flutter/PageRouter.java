package com.example.gank_flutter;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class PageRouter {

    public static final String NATIVE_PAGE_URL = "native://";
    public static final String FLUTTER_PAGE_URL = "flutter://";

    public static boolean openPageByUrl(Context context, String url) {
        return openPageByUrl(context, url, 0);
    }

    public static boolean openPageByUrl(Context context, String url, int requestCode) {
        try {
            if (url.startsWith(FLUTTER_PAGE_URL)) {
                context.startActivity(new Intent(context, MainFlutterActivity.class));
                return true;
            } else if (url.startsWith(NATIVE_PAGE_URL)) {
                context.startActivity(new Intent(context, HistoryActivity.class));
                return true;
            } else {
                return false;
            }
        } catch (Throwable t) {
            return false;
        }
    }
}