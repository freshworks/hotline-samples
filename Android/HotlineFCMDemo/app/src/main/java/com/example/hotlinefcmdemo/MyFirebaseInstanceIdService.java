package com.example.hotlinefcmdemo;

import android.util.Log;

import com.freshdesk.hotline.Hotline;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.FirebaseInstanceIdService;

/**
 * Created by prasannan on 11/08/16.
 */
public class MyFirebaseInstanceIdService extends FirebaseInstanceIdService {

    private static final String TAG = "fcmdemo";

    @Override
    public void onTokenRefresh() {
        // Get updated InstanceID token.
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
        Log.d(TAG, "Refreshed token: " + refreshedToken);

        // If you want to send messages to this application instance or
        // manage this apps subscriptions on the server side, send the
        // Instance ID token to your app server.
        sendRegistrationToServer(refreshedToken);
    }

    public void sendRegistrationToServer(String token) {
       Hotline.getInstance(this).updateGcmRegistrationToken(token);
    }
}
