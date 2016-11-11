package org.strongswan.android.netgroup.secured;


import java.util.ArrayList;

import org.strongswan.android.R;

import android.app.Activity;
import android.app.FragmentManager;
import android.os.Bundle;


public class Setting_Activity extends Activity {
	
	
    final CharSequence[] items={"Mobile Network","Wi-Fi Network"};
    int itemsChecked=-1;
    
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.setting_layout);
		
		
		FragmentManager manager = getFragmentManager();
        SingleChoiceDialogFragment dialog = new SingleChoiceDialogFragment();
         
        Bundle bundle = new Bundle();
        bundle.putStringArrayList(SingleChoiceDialogFragment.DATA, getItems());     // Require ArrayList
        bundle.putInt(SingleChoiceDialogFragment.SELECTED, 0);
        dialog.setArguments(bundle);
        dialog.show(manager, "Dialog");

     }
	
			
	private ArrayList<String> getItems(){
        ArrayList<String> ret_val = new ArrayList<String>();
         
        ret_val.add("Mobile network");
        ret_val.add("Wi-Fi network");
        return ret_val;
    }
		
	
	
}