package org.strongswan.android.netgroup.secured;

import org.strongswan.android.R;

import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;

public class NotificationSender {
	
	NotificationManager mNotificationManager;
	Intent destIntent,selectedIntent;
	PendingIntent deleteIntent,selectedPendingIntent;
	Notification notification;
	
	
	private static class NotificationSender_holder{
		private final static NotificationSender INSTANCE= new NotificationSender();
		
	}
	
	public static NotificationSender getInstance(){
		return NotificationSender_holder.INSTANCE;
	}
	
	public  void InitiateNotificationSender(Context context){
		mNotificationManager =(NotificationManager)context.getSystemService(Context.NOTIFICATION_SERVICE);
		destIntent = new Intent(context,ChangeState_Activity2.class);
		deleteIntent = PendingIntent.getActivity(context, 0, destIntent, PendingIntent.FLAG_CANCEL_CURRENT);
		selectedIntent=new Intent("org.strongswan.android.netgroup.secured.action.ALIAS");
		selectedPendingIntent=PendingIntent.getActivity(context, 0, selectedIntent, PendingIntent.FLAG_CANCEL_CURRENT);
	}
	
	public void SendNotification(Context context,String msg){
		notification = new NotificationCompat.Builder(context)
		.setSmallIcon(R.drawable.connectivity_change)
		.setAutoCancel(true)
		.setDeleteIntent(deleteIntent)
		.setContentIntent(selectedPendingIntent).setContentTitle("State changed").setContentText(msg).build();
		mNotificationManager.notify(0, notification);
	}
}
