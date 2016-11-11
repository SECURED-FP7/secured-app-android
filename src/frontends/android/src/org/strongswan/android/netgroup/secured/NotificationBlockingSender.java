package org.strongswan.android.netgroup.secured;

import org.strongswan.android.R;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;

public class NotificationBlockingSender {
	NotificationManager mNotificationManager;
	Intent destIntent,selectedIntent;
	PendingIntent deleteIntent,selectedPendingIntent;
	Notification notification;
	
	
	private static class NotificationBlockingSender_holder{
		private final static NotificationBlockingSender INSTANCE= new NotificationBlockingSender();
		
	}
	
	public static NotificationBlockingSender getInstance(){
		return NotificationBlockingSender_holder.INSTANCE;
	}
	
	
	public  void InitiateNotificationSender_forTrafficBlock(Context context){
		mNotificationManager =(NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
		destIntent = new Intent(context,BlockingTraffic_Activity.class);
		deleteIntent = PendingIntent.getActivity(context, 0, destIntent, PendingIntent.FLAG_CANCEL_CURRENT);
		selectedIntent=new Intent("org.strongswan.android.netgroup.secured.action.ALIAS2");
		selectedPendingIntent=PendingIntent.getActivity(context, 0, selectedIntent, PendingIntent.FLAG_CANCEL_CURRENT);
	}
	public void SendNotification_forTrafficBlock(Context context,String msg){
		notification = new NotificationCompat.Builder(context)
		.setSmallIcon(R.drawable.ic_launcher)
		.setAutoCancel(true)
		.setDeleteIntent(deleteIntent)
		.setContentIntent(selectedPendingIntent).setContentTitle("Tunnel not established").setContentText(msg).build();
		mNotificationManager.notify(0, notification);
	}
	
}
