package org.strongswan.android.netgroup.secured;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
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
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Gravity;
import android.view.Menu;
import android.view.View;
//import android.webkit.WebView;
//import android.webkit.WebViewClient;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.CompoundButton.OnCheckedChangeListener;

public class Status_Activity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.status_layout);
		
		GetResult result = new GetResult();
        result.execute();
        
        
        TextView textView = (TextView) findViewById(R.id.status_received);
        try {
			textView.setText(result.get());
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	private class GetResult extends AsyncTask<String, Void, String> {
		
		@Override
		protected String doInBackground(String... params) {
			String url = "http://www.thomas-bayer.com/sqlrest/CUSTOMER/3/";
			String[] persone = null; // conterrà i risultati
			String risultato=null;
			HttpClient request = new DefaultHttpClient();
			HttpGet get = new HttpGet(url);
			HttpResponse response;
			try {
				response = request.execute(get);

				int responseCode = response.getStatusLine().getStatusCode();
				if (responseCode == 200) {
					InputStream istream = response.getEntity().getContent();
					BufferedReader r = new BufferedReader(new InputStreamReader(
							istream));
					String s = null;
					StringBuffer sb = new StringBuffer();
					while ((s = r.readLine()) != null) {
						sb.append(s);
					}
risultato=sb.toString();
				}
			} catch (ClientProtocolException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			/*
			 * JSONArray array=new JSONArray(sb.toString()); persone=new
			 * String[array.length()]; for(int i=0;i&lt;array.length();i++) { String
			 * nome=array.getJSONObject(i).getString(&quot;nome&quot;); String
			 * cognome=array.getJSONObject(i).getString(&quot;cognome&quot;); String
			 * eta=array.getJSONObject(i).getString(&quot;eta&quot;);
			 * persone[i]=nome+&quot; &quot;+cognome+&quot; di anni &quot;+eta; }
			 * return persone;
			 */
			
			return risultato;
		}

	}

}
