package org.strongswan.android.netgroup.secured;

import org.strongswan.android.R;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Typeface;
import android.net.VpnService;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class BlockingTraffic_Activity extends Activity implements
		View.OnClickListener {
	Intent firewallIntent;
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.block_traffic_layout);
		findViewById(R.id.button_Block).setOnClickListener(this);
		firewallIntent=new Intent(this, my_firewall_service.class);
	}

	@Override
	public void onClick(View v) {
		Button button = (Button) findViewById(R.id.button_Block);
		if (!button.getText().equals("LOCKED!")) {
			Intent intent = VpnService.prepare(this);

			if (intent != null) {

				startActivityForResult(intent, 0);
			} else {
				onActivityResult(0, RESULT_OK, null);
			}
			button.setText("LOCKED!");
			button.setClickable(false);
		} else {
			//stopService(firewallIntent);
			//button.setText("LOCK!");
			
			
		}
	}

	@Override
	protected void onActivityResult(int request, int result, Intent data) {
		if (result == RESULT_OK) {
			startService(firewallIntent);
		}
	}

}
