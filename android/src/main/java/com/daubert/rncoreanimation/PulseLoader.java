package com.daubert.rncoreanimation;

import android.view.View;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;

public class PulseLoader extends SimpleViewManager {
    @Override
    public String getName() {
        return "JZHPulseLoaderView";
    }

    @Override
    protected View createViewInstance(ThemedReactContext reactContext) {
        return new View(reactContext);
    }


}
