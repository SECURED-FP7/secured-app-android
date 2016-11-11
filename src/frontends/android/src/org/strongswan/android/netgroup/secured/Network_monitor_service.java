package org.strongswan.android.netgroup.secured;

import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.os.IBinder;
import android.widget.Toast;

public class Network_monitor_service extends Service {

	   /** indicates how to behave if the service is killed */
	   int mStartMode;
	   /** interface for clients that bind */
	   IBinder mBinder =null;     
	   NetworkInfo_receiver info_receiver;
	   
	   int cnt=0;

	   /** Called when the service is being created. */
	   @Override
	   public void onCreate() {
		   //inizializza il gestore delle notifiche
		   NotificationSender.getInstance().InitiateNotificationSender(getBaseContext());
		   //crea l'oggetto che intercetterà i cambiamenti di connettività
		   info_receiver=new NetworkInfo_receiver();
	   }

	   /** The service is starting, due to a call to startService() */
	   @Override
	   public int onStartCommand(Intent intent, int flags, int startId) {
		   //registra il broadcast receiver
		   registerReceiver(info_receiver,new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION));
		   return mStartMode;
	   }


	   /** Called when The service is no longer used and is being destroyed */
	   @Override
	   public void onDestroy() {
		   super.onDestroy();
		   unregisterReceiver(info_receiver);
	   }

	   @Override
		public IBinder onBind(Intent intent) {
		   // TODO Auto-generated method stub
		   return null;
	   }
	   
	   public class NetworkInfo_receiver extends BroadcastReceiver {
		   	
			@Override
			public void onReceive(Context context, Intent intent) {
				// TODO Auto-generated method stub
				//ConnectivityManager is class that answers queries about the state of network
				//connectivity. It also notifies applications when network connectivity changes.
				//we get an instance of this class by calling Context.getSystemService
				ConnectivityManager connectivitymanager = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
				//state variable is used to get the actual state of the Network
				android.net.NetworkInfo.State state = connectivitymanager.getNetworkInfo(1).getState();
				//state1 on the other hand used as a comparator which is defined as connected
				android.net.NetworkInfo.State state1 = android.net.NetworkInfo.State.CONNECTED;
				
				
				
				//INIZIO VERSIONE SEMPLIFICATA
				
				
				Toast.makeText(context, "Warning: you are no longer protected!", Toast.LENGTH_SHORT).show();
				if(!First_time_notification.getInstance().isFirstTime())
					NotificationSender.getInstance().SendNotification(getBaseContext(), "Warning: you are no longer protected!");
				else
					First_time_notification.getInstance().setTime(false);
				
				//FINE VERSIONE SEMPLIFICATA
				// IL SEGUITO E' LA VECCHIA VERSIONE ESTESA
				
				
				/*
				boolean flag = false;
				//If network is connected state variable gets the value of state1, which is CONNECTED
				if(state1 == state){
					flag = true;
				
					//This instance of method is used to display Toasts(alert dialogue)
					Toast.makeText(context, "Wi-fi activated", Toast.LENGTH_SHORT).show();
					if(!First_time_notification.getInstance().isFirstTime())
						NotificationSender.getInstance().SendNotification(getBaseContext(), "Wi-fi activated");
					else
						First_time_notification.getInstance().setTime(false);
				}		
				
				android.net.NetworkInfo.State state2 = connectivitymanager.getNetworkInfo(0).getState();
				if(android.net.NetworkInfo.State.CONNECTED == state2) {
					Toast.makeText(context, "Mobile activated", Toast.LENGTH_SHORT).show();
					if(!First_time_notification.getInstance().isFirstTime())
						NotificationSender.getInstance().SendNotification(getBaseContext(), "Mobile activated");
					else
						First_time_notification.getInstance().setTime(false);
					
					flag = true; 
				}
				
				//This condition works whenever the both state is not Connected
				if(!flag){
					Toast.makeText(context, "No connectivity", Toast.LENGTH_SHORT).show();
					if(!First_time_notification.getInstance().isFirstTime())
						NotificationSender.getInstance().SendNotification(getBaseContext(), "No connectivity");
					else
						First_time_notification.getInstance().setTime(false);
					
				}
				*/
			}
	   }
	   
	   
	   
}