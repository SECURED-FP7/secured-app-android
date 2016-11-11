package org.strongswan.android.netgroup.secured;

import java.util.ArrayList;
import java.util.List;

import org.strongswan.android.R;

import android.app.Activity;
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
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;
import android.view.View.OnClickListener;

public class ChangeState_Activity2 extends Activity {
	TextView infoText;

	
	Button setter_button;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.change_state);
		infoText = (TextView) findViewById(R.id.info_text);
		TextView instructions = (TextView) findViewById(R.id.instructions);
		Button clickButton = (Button) findViewById(R.id.button_reconnect);
		clickButton.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				final Intent intent = new Intent(getBaseContext(),
						org.strongswan.android.ui.MainActivity.class);
				intent.setFlags(Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
				startActivity(intent);
				finish();
			}
		});

		infoText.setText("You are no longer connected to your SECURED network.");

		if (AppStatus.getInstance(this).isOnline(this)) {
			instructions.setText("Although you can browse the Internet, you are now at risk.");
			
			
		} else {
			instructions.setText("No network connection");

		}

	}

	
}
