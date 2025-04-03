package com.gail.gailconnect;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

public class PedometerService extends Service {
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if (intent != null && intent.getAction() != null) {
            switch (intent.getAction()) {
                case "START":
                    // Handle start logic
                    break;
                case "STOP":
                    // Handle stop logic
                    stopSelf();
                    break;
            }
        }
        return super.onStartCommand(intent, flags, startId);
    }
}
