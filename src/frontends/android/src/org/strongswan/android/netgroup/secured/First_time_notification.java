package org.strongswan.android.netgroup.secured;


public class First_time_notification {
	boolean first=true;
	
	private static class First_time_notificationHolder {
        private final static First_time_notification INSTANCE = new First_time_notification();
    }
	
	public static First_time_notification getInstance(){
		return First_time_notificationHolder.INSTANCE;
	}
	
	public boolean isFirstTime(){
		return first;
	}
	
	public void setTime(boolean t){
		this.first=t;
	}
}
