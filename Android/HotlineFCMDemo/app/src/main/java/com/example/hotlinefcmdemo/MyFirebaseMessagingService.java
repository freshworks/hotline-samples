package com.example.hotlinefcmdemo;

import com.freshdesk.hotline.Hotline;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

/**
 * Created by prasannan on 11/08/16.
 */
public class MyFirebaseMessagingService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Not getting messages here? See why this may be: https://goo.gl/39bRNJ

        if (Hotline.isHotlineNotification(remoteMessage)) {
            Hotline.getInstance(this).handleFcmMessage(remoteMessage);
        } else {
            //Handle notifications for app
        }
    }
}
