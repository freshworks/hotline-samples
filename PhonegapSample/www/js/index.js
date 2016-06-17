var app = {
    // Application Constructor
    initialize: function() {
        this.bindEvents();
    },
    // Bind Event Listeners
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    // deviceready Event Handler
    //
    // The scope of 'this' is the event. In order to call the 'receivedEvent'
    // function, we must explicitly call 'app.receivedEvent(...);'
    onDeviceReady: function() {
        console.log("on device ready");
        app.receivedEvent('deviceready');
        
        console.log(window.Hotline);
        // Initialize Hotline with your AppId & AppKey from your portal https://web.hotline.io/settings/apisdk
        window.Hotline.init({
            appId       : "<Your App Id>",
            appKey      : "<Your App Key>",
            domain      : "app.hotline.io"
        });
        
        document.getElementById("launch_faqs").onclick = function() { 
            console.log("Inside launch support");
            window.Hotline.showFAQs();
        };

        document.getElementById("launch_conversations").onclick = function() {
            console.log("Inside launch Conversations");
            window.Hotline.showConversations();

        }; 
        
        //Allow hotline to take care of push notifications
        //If your app already handles push notification then you don't need the following.
        window.Hotline.registerPushNotification("<ANDROID_SENDER_ID>");

        document.getElementById("update_user_form").onclick = function() {

            var email = document.createElement("INPUT");
            email.setAttribute("type", "email");
            email.setAttribute("value", "john@example.com");
            document.body.appendChild(email);

            var name = document.createElement("INPUT");
            name.setAttribute("type", "text");
            name.setAttribute("value", "pablo neruda");
            document.body.appendChild(name);
            
            var countryCode = document.createElement("INPUT");
            countryCode.setAttribute("type", "number");
            countryCode.setAttribute("value", "+91");
            document.body.appendChild(countryCode);
            
            var phoneNumber = document.createElement("INPUT");
            phoneNumber.setAttribute("type", "number");
            phoneNumber.setAttribute("value", "123456");
            document.body.appendChild(phoneNumber);
            
            var externalId = document.createElement("INPUT");
            externalId.setAttribute("type", "text");
            externalId.setAttribute("value", "external id");
            document.body.appendChild(externalId);
            
            var submitUser = document.createElement("INPUT");
            submitUser.setAttribute("type", "button");
            submitUser.setAttribute("value", "update user");
            document.body.appendChild(submitUser);
            submitUser.onclick = function() {
                 window.Hotline.updateUser({ 
                   "name" : name.value, 
                   "email" : email.value, 
                   "externalId" : externalId.value, 
                   "countryCode" : countryCode.value,
                   "phoneNumber" : phoneNumber.value
                });
            };
            
        };
    }

        setInterval(function(){
            window.Hotline.unreadCount(function(success,val){
                if(success && val > 0 ){
                    document.getElementById("launch_conversations").innerHTML = "Conversations (" + val + " unread)" ;
                }
                else {
                    document.getElementById("launch_conversations").innerHTML = "Conversations";
                }
            });
        }, 5000);
    },

    receivedEvent: function(id) {
        console.log('Received Event: ' + id);
    }
}

app.initialize();
