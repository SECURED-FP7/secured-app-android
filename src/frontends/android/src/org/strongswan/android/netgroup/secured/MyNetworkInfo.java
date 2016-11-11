package org.strongswan.android.netgroup.secured;

public class MyNetworkInfo {
	
	private boolean isWifi=false,isMobile=false,isConnected=false;
	private String SSID, defaultGateway,internalIP; //wifi_info   
	private String Apn;  //mobile info 
	private String subType;
	private static class MyNetworkInfoHolder {
        private final static MyNetworkInfo INSTANCE = new MyNetworkInfo();
    }
	
	public static MyNetworkInfo getInstance(){
		return MyNetworkInfoHolder.INSTANCE;
	}
	
	//metodi setter
	public void setWifi(){
		this.isWifi=true;
		this.isMobile=false;
		this.isConnected=true;
	}
	
	public void setMobile(){
		this.isWifi=false;
		this.isMobile=true;
		this.isConnected=true;
		this.defaultGateway="";
	}
	
	public void setSSID(String ssid){
		this.SSID=ssid;
	}
	
	public void setDefaultGateway(String DG){
		this.defaultGateway=DG;
	}
	
	public void setInternalIP(String ip){
		this.internalIP=ip;
	}
	
	public void setAPN(String apn){
		this.Apn=apn;
	}
	
	//metodi getter
	public boolean isWifi(){
		return this.isWifi;
		
	}
	
	public boolean isMobile(){
		return this.isMobile;
	}
	
	public String getSSID(){
		return this.SSID;
	}
	
	public String getDefaultGateway(){
		return this.defaultGateway;
	}
	
	public String getInternalIP(){
		return this.internalIP;
	}
	
	public String getAPN(){
		return this.Apn;
	}

	public void setSubType(String string) {
		// TODO Auto-generated method stub
		subType=string;
	}
	
	public String getSubType( ) {
		// TODO Auto-generated method stub
		return subType;
	}
}
