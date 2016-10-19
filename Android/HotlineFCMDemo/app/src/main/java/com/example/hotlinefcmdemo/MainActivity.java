package com.example.hotlinefcmdemo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import com.freshdesk.hotline.Hotline;
import com.freshdesk.hotline.HotlineConfig;
import com.freshdesk.hotline.HotlineUser;

/**
 * Step to run this sample app.
 *
 * 1. Copy you app id and app keys from the Hotline SDK settings page (https://web.hotline.io/settings/apisdk)
 *    and update the variables below with the respective values
 *      - HOTLINE_APP_ID
 *      - HOTLINE_APP_KEY
 *
 * 2. Download and place the "google-services.json" from the Firebase consosle (https://console.firebase.google.com/)
 *
 * 3. Configure the FCM Server Key in the "SDK & APP" settings page in Hotline web portal (https://web.hotline.io/settings/apisdk)
 *
 */
public class MainActivity extends AppCompatActivity {

    public static final String HOTLINE_APP_ID = "";
    public static final String HOTLINE_APP_KEY = "";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize Hotline
        HotlineConfig hotlineConfig = new HotlineConfig(HOTLINE_APP_ID, HOTLINE_APP_KEY);
        Hotline.getInstance(this).init(hotlineConfig);

        // Update user info with Hotline
        HotlineUser user = Hotline.getInstance(this).getUser();
        user.setName("Guest");
        user.setEmail("user_" + System.currentTimeMillis() + "@user.user");
        Hotline.getInstance(this).updateUser(user);

        //Attach click listeners to UI elements
        findViewById(R.id.btn_show_faq).setOnClickListener(btnClickListener);
        findViewById(R.id.btn_show_conv).setOnClickListener(btnClickListener);
    }

    View.OnClickListener btnClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            if(v.getId() == R.id.btn_show_conv) {

                Hotline.showConversations(getApplicationContext());

            } else if(v.getId() == R.id.btn_show_faq) {

                Hotline.showFAQs(getApplicationContext());

            }
        }
    };
}
