package org.strongswan.android.netgroup.secured;

import java.util.ArrayList;
import java.util.List;

import org.strongswan.android.R;

import android.app.Activity;
import android.app.FragmentManager;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.Toast;
import android.widget.AdapterView.OnItemClickListener;

public class MainActivity extends Activity implements OnItemClickListener {
	public static final Integer[] menu_images = { R.drawable.negotiation, R.drawable.home,
			R.drawable.settings, R.drawable.info };
	public static final String[] menu_titles = new String[] { "Connect", "Status",
			"Settings", "Info" };
	public static final String[] menu_desc = { "Connect to the NED",  "Show connection status",
		"Applications's settings", "Show main application info"};
	ListView listView;
	List<RowItem> rowItems;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		rowItems = new ArrayList<RowItem>();
		for (int i = 0; i < menu_titles.length; i++) {
			RowItem item = new RowItem(menu_images[i], menu_titles[i],
					menu_desc[i]);
			rowItems.add(item);
		}

		listView = (ListView) findViewById(R.id.list);
		// listView.setVisibility(View.VISIBLE);
		CustomBaseAdapter adapter = new CustomBaseAdapter(this, rowItems);
		listView.setAdapter(adapter);
		listView.setOnItemClickListener(this);

	}

	@Override
	public void onItemClick(AdapterView<?> parent, View view, int position,
			long id) {

		final Intent intent;

		switch (position) {

		case 0:
			intent = new Intent(this, org.strongswan.android.ui.MainActivity.class);
			startActivity(intent);
			/*
			FragmentManager manager = getFragmentManager();
			SingleChoiceConnectionFragment dialog = new SingleChoiceConnectionFragment();

			Bundle bundle = new Bundle();
			bundle.putStringArrayList(SingleChoiceConnectionFragment.DATA,
					getItems()); // Require ArrayList
			bundle.putInt(SingleChoiceConnectionFragment.SELECTED, 0);
			dialog.setArguments(bundle);
			dialog.show(manager, "Dialog");
			*/
			break;
		case 1:
			intent = new Intent(this, Status_Activity.class);
			startActivity(intent);
			break;
		case 2:
			intent = new Intent(this, Settings_Activity.class);
			startActivity(intent);
			break;
		case 3:
			intent = new Intent(this, ConnectivityInfo_Activity.class);
			startActivity(intent);
			break;
		
		default:
			break;
		}

	}

	private ArrayList<String> getItems() {
		ArrayList<String> ret_val = new ArrayList<String>();

		ret_val.add("Default NED");
		ret_val.add("New NED");
		return ret_val;
	}

}
