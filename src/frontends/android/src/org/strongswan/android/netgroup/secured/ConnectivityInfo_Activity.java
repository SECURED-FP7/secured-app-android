package org.strongswan.android.netgroup.secured;

import java.util.ArrayList;
import java.util.List;

import org.strongswan.android.R;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Context;
import android.content.Intent;
import android.graphics.Typeface;
import android.net.ConnectivityManager;
import android.net.DhcpInfo;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
//import android.webkit.WebView;
//import android.webkit.WebViewClient;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class ConnectivityInfo_Activity extends Activity implements OnItemClickListener {
	TextView info;
	boolean isWifi=false;
	 //private WebView mWebView;  
     //private String url = "http://www.mioip.it/"; 
	
	/** 
     * Dichiariamo l'attributo di classe url in cui  
     * salviamo l'indirizzo web che aprirà la webview 
     */  
   
   
   public static final String[] Wifi_titles = new String[] { "Connection",
       "SSID", "Default Gateway", "Internal IP address" };

   public static final String[] mobile_titles = new String[] { "Connection",
       "Access Point Name", "Roaming" };
   
  

   public static final Integer[] Wifi_images = { R.drawable.wifi_icon,
       R.drawable.ssid, R.drawable.router, R.drawable.lan, R.drawable.white};
   
   public static final Integer[] mobile_images = { R.drawable.mobile,
       R.drawable.apn_icon,R.drawable.roaming, R.drawable.white };
   
   ListView listView;
   List<RowItem> rowItems;
   Button setter_button;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		ConnectivityManager cm = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
       
		if (AppStatus.getInstance(this).isOnline(this)) {
			setContentView(R.layout.connectivity_info);
			
			info=(TextView) findViewById(R.id.info_text);
			info.setText("Network information");
			
			//negotiate_button=(Button)findViewById(R.id.button_start);
			//carichiamo la webview dentro il layout specificato  
	       //mWebView = (WebView) findViewById(R.id.webView1);
			
			
			
			
			NetworkInfo n_info= cm.getActiveNetworkInfo();
			if(n_info.getTypeName().equalsIgnoreCase("wifi")){
				this.isWifi=true;
				final WifiManager manager = (WifiManager) super.getSystemService(WIFI_SERVICE);
				final DhcpInfo dhcp = manager.getDhcpInfo();
				final WifiInfo wi =manager.getConnectionInfo();
				//wi.getSSID(); ulteriori informazioni di rete
				//wi.getIpAddress();
				//info.setText("Tipo di connessione:  "+ n_info.getTypeName()+"\nSSID: "+wi.getSSID()+"\nIndirizzo DG: "+intToIp(dhcp.gateway)+"\nIndirizzo IP interno:  "+intToIp(wi.getIpAddress())+"\nIndirizzo IP publico (by www.mio-ip.it):");
			    final String[] Wifi_descriptions = new String[] {
			    		n_info.getTypeName(),wi.getSSID(), intToIp(dhcp.gateway),intToIp(wi.getIpAddress())};
				
			    MyNetworkInfo.getInstance().setWifi();
			    MyNetworkInfo.getInstance().setSSID(wi.getSSID());
			    MyNetworkInfo.getInstance().setDefaultGateway(intToIp(dhcp.gateway));
			    MyNetworkInfo.getInstance().setInternalIP(intToIp(wi.getIpAddress()));
			    
			    
				
			    rowItems = new ArrayList<RowItem>();
		        for (int i = 0; i < Wifi_titles.length; i++) {
		            RowItem item = new RowItem(Wifi_images[i], Wifi_titles[i],Wifi_descriptions[i]);
		            rowItems.add(item);
		        }
		        //negotiate_button.setText("Connect");
			}else{
				//info.setText("Tipo di connessione:  "+ n_info.getTypeName()+"\nAttendi un momento per conoscere il tuo indirizzo ip pubblico (by www.mio-ip.it):");
				final String[] mobile_descriptions = new String[] { n_info.getTypeName()+"["+n_info.getSubtypeName()+"]", n_info.getExtraInfo().toString(), (n_info.isRoaming()? "True":"False")};
				this.isWifi=false;

				MyNetworkInfo.getInstance().setMobile();
				MyNetworkInfo.getInstance().setAPN(n_info.getExtraInfo().toString());
				MyNetworkInfo.getInstance().setSubType(n_info.getSubtypeName().toString());
				
				//next_info.setTypeface(Typeface.createFromAsset(getAssets(), "RemachineScript_Personal_Use.ttf"));

				//next_info.setText("You can connect to the NED clicking this button");
				
				rowItems = new ArrayList<RowItem>();
		        for (int i = 0; i < mobile_titles.length; i++) {
		            RowItem item = new RowItem(mobile_images[i], mobile_titles[i],mobile_descriptions[i]);
		            rowItems.add(item);
		        }
		        
		        
				//next_info.setText("Click to connect to the NED");
				//negotiate_button.setText("Connect");
			}
			
			listView = (ListView) findViewById(R.id.list1);
			
	        CustomBaseAdapter2 adapter = new CustomBaseAdapter2(this, rowItems);
	        listView.setAdapter(adapter);
	        listView.setOnItemClickListener(this);
			
	        
			
			
		} else {
			// SE NON C'E' CONNESSIONE
			setContentView(R.layout.connectivity_info_no_conn);
			info=(TextView) findViewById(R.id.info_text);
			info.setText("No connection");
			//next_info.setText("  clicca per procedere con le opportune impostazioni!");
			//setting_info=(TextView)findViewById(R.id.settin_info);
			//setting_info.setText("Click to connect to wi-fi or mobile!");
			//setting_info.setVisibility(View.VISIBLE);
			
			
			setter_button=(Button)findViewById(R.id.connect_btn);
			setter_button.setVisibility(View.VISIBLE);
			setter_button.setOnClickListener(onClickListener);
		}
		
		
	}
	
	
	
	
	@Override
   public void onItemClick(AdapterView<?> parent, View view, int position,long id) {
       Toast toast = Toast.makeText(getApplicationContext(),
               "Item " + (position + 1) + ": " + rowItems.get(position),
               Toast.LENGTH_SHORT);
       toast.setGravity(Gravity.BOTTOM|Gravity.CENTER_HORIZONTAL, 0, 0);
       toast.show();
   }
	
	public String intToIp(int addr) {
	    return  ((addr & 0xFF) + "." + 
	            ((addr >>>= 8) & 0xFF) + "." + 
	            ((addr >>>= 8) & 0xFF) + "." + 
	            ((addr >>>= 8) & 0xFF));
	}
	/*
	@Override
	   public boolean onCreateOptionsMenu(Menu menu) {
	      // Inflate the menu; this adds items to the action bar if it is present.
	      getMenuInflater().inflate(R.menu.splash, menu);
	      return true;
	   }
	*/
	public void startSetting() {
		final Intent intent = new Intent(this,Setting_Activity.class);
		startActivity(intent);
		finish();
	}
	
	
	private ArrayList<String> getItems() {
		ArrayList<String> ret_val = new ArrayList<String>();

		ret_val.add("Default NED");
		ret_val.add("New NED");
		return ret_val;
	}
	/*private class MyBrowser extends WebViewClient {
	      @Override
	      public boolean shouldOverrideUrlLoading(WebView view, String url) {
	         view.loadUrl(url);
	         return true;
	      }
	   }
	*/
	
	private OnClickListener onClickListener = new OnClickListener() {
	     @Override
	     public void onClick(final View v) {
	    	 startSetting();

	   }};
}
