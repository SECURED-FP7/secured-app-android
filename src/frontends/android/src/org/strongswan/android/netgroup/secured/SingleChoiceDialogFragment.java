package org.strongswan.android.netgroup.secured;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

import org.strongswan.android.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.DialogFragment;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.DialogInterface.OnClickListener;
import android.content.res.Resources;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;
import android.net.ConnectivityManager;
import android.net.wifi.WifiManager;


public class SingleChoiceDialogFragment extends DialogFragment 
{
    public static final String DATA = "items";
     
    public static final String SELECTED = "selected";
      
    List<String> list;
    
    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) 
    {
        Resources res = getActivity().getResources();
        Bundle bundle = getArguments();
         
        AlertDialog.Builder dialog = new AlertDialog.Builder(getActivity());
         
        dialog.setTitle("Select your favourite netwkork:");
        dialog.setIcon(R.drawable.net_icon);
        dialog.setPositiveButton("OK", new PositiveButtonClickListener());
         
        this.list = (List<String>)bundle.get(DATA);
        
        int position = bundle.getInt(SELECTED);
         
        CharSequence[] cs = list.toArray(new CharSequence[list.size()]);
        dialog.setSingleChoiceItems(cs, position, selectItemListener);
         
        return dialog.create();
    }
     
    class PositiveButtonClickListener implements DialogInterface.OnClickListener
    {
        @Override
        public void onClick(DialogInterface dialog, int which) 
        {
            dialog.dismiss();
            // Refresh main activity upon close of dialog box
            Intent refresh = new Intent(getActivity(), ConnectivityInfo_Activity.class);
            startActivity(refresh);
            getActivity().finish();
        }
    }
     
    OnClickListener selectItemListener = new OnClickListener(){
 
        @Override
        public void onClick(DialogInterface dialog, int which) 
        {
            // process 
            //which means position
        	// TODO Auto-generated method stub
			
			
			//When you check the first row (Mobile Data) this condition statement is activated
			if(which==0){
				First_time_notification.getInstance().setTime(true);
				//wi-fi is turned off
				((WifiManager)getActivity().getSystemService("wifi")).setWifiEnabled(false);
				//Mobile data is enabled, this is postdefined method to control mobile data
				setMobileDataEnabled(getActivity(), true);
			}
			if(which==1){
				First_time_notification.getInstance().setTime(true);
				setMobileDataEnabled(getActivity(), false);
				((WifiManager)getActivity().getSystemService("wifi")).setWifiEnabled(true);
				goToSystemWiFi_Setting();
			}
			
			Toast.makeText(getActivity(),list.get(which) , Toast.LENGTH_LONG).show();
        	
        }
    };
    
    private void setMobileDataEnabled(Context context, boolean enable) {
		//enable boolean tells whether to switch it on or off
		ConnectivityManager con_Manager = (ConnectivityManager) context.getSystemService(Activity.CONNECTIVITY_SERVICE);
		
		Method myMethod = getMethodFromClass(con_Manager, "setMobileDataEnabled");
		
		runMethodofClass(con_Manager, myMethod, enable);
	}
		
	private Method getMethodFromClass(Object con_Manager, String methodName) {
		final String TAG = "getMethodFromClass";
		Class<?> whichClass = null;
		//We try to get Method from the Class, when it is not found
		//the Exception is thrown, so we catch it and Log the error
		try {
		
			whichClass = Class.forName(con_Manager.getClass().getName());
		
		} catch (ClassNotFoundException e2) {
			Log.d(TAG, "class not found");
		}
		
		Method method = null;
		try {
			//method = whichClass.getDeclaredMethod(methodName);
			Method[] methods = whichClass.getDeclaredMethods();
			for (Method m : methods) {
				if (m.getName().contains(methodName)) {
					method = m;
				}
			}
		
		} catch (SecurityException e2) {
			Log.d(TAG, "SecurityException for " + methodName);
		}
		
		return method;
		
	}
		
	private Object runMethodofClass(Object con_Manager, Method method, Object... argv) {
		Object result = null;
		if (method == null) 
			return result;
			
		method.setAccessible(true);
		try {
				result = method.invoke(con_Manager, argv);
		} catch (IllegalArgumentException e) {
			// Log.d(TAG, "IllegalArgumentException for " + method.getName());
		} catch (IllegalAccessException e) {
			//Log.d(TAG, "IllegalAccessException for " + method.getName()); } catch (InvocationTargetException e) {
			//Log.d(TAG, "InvocationTargetException for " + method.getName()
			// + "; Reason: " + e.getLocalizedMessage());
		} catch (InvocationTargetException e) {
			//Log.d(TAG, "InvocationTargetException for " + method.getName()
			// + "; Reason: " + e.getLocalizedMessage());
		}
		return result;
	}
	
	private void goToSystemWiFi_Setting() {
		// TODO Auto-generated method stub
		Intent intent=new Intent(android.provider.Settings.ACTION_WIFI_SETTINGS);
        startActivity(intent);
	}
}   