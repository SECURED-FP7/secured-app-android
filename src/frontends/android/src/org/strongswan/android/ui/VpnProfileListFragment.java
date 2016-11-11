/*
 * Copyright (C) 2012 Tobias Brunner
 * Copyright (C) 2012 Giuliano Grassi
 * Copyright (C) 2012 Ralf Sager
 * Hochschule fuer Technik Rapperswil
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 */

package org.strongswan.android.ui;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.strongswan.android.R;
import org.strongswan.android.data.VpnProfile;
import org.strongswan.android.data.VpnProfileDataSource;
import org.strongswan.android.data.VpnType;
import org.strongswan.android.ui.adapter.VpnProfileAdapter;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Fragment;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.res.TypedArray;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.database.sqlite.SQLiteQueryBuilder;
import android.net.DhcpInfo;
import android.net.wifi.WifiManager;
import android.os.Bundle;
import android.util.AttributeSet;
import android.util.Log;
import android.view.ActionMode;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AbsListView.MultiChoiceModeListener;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ListView;
import android.widget.Toast;

public class VpnProfileListFragment extends Fragment {
	private static final int ADD_REQUEST = 1;
	private static final int EDIT_REQUEST = 2;

	private List<VpnProfile> mVpnProfiles;
	private VpnProfileDataSource mDataSource;
	private VpnProfileAdapter mListAdapter;
	private ListView mListView;
	private OnVpnProfileSelectedListener mListener;
	private boolean mReadOnly;
	
	private static final String DATABASE_NAME = "strongswan.db";
	private static final String TABLE_VPNPROFILE = "vpnprofile";
	private static final int DATABASE_VERSION = 4;
	private static final String TAG = VpnProfileDataSource.class
			.getSimpleName();
	private static final String[] ALL_COLUMNS = new String[] { VpnProfileDataSource.KEY_ID,
		VpnProfileDataSource.KEY_NAME, VpnProfileDataSource.KEY_GATEWAY, VpnProfileDataSource.KEY_VPN_TYPE, VpnProfileDataSource.KEY_USERNAME, VpnProfileDataSource.KEY_PASSWORD,
		VpnProfileDataSource.KEY_CERTIFICATE, VpnProfileDataSource.KEY_USER_CERTIFICATE, VpnProfileDataSource.KEY_REMOTE_ATTESTATION, };

	/**
	 * The activity containing this fragment should implement this interface
	 */
	public interface OnVpnProfileSelectedListener {
		public void onVpnProfileSelected(VpnProfile profile);
	}

	@Override
	public void onInflate(Activity activity, AttributeSet attrs,
			Bundle savedInstanceState) {
		super.onInflate(activity, attrs, savedInstanceState);
		TypedArray a = activity.obtainStyledAttributes(attrs,
				R.styleable.Fragment);
		mReadOnly = a.getBoolean(R.styleable.Fragment_read_only, false);
		a.recycle();
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {
		View view = inflater.inflate(R.layout.profile_list_fragment, null);

		mListView = (ListView) view.findViewById(R.id.profile_list);
		mListView.setAdapter(mListAdapter);
		mListView.setEmptyView(view.findViewById(R.id.profile_list_empty));
		mListView.setOnItemClickListener(mVpnProfileClicked);

		if (!mReadOnly) {
			mListView.setChoiceMode(ListView.CHOICE_MODE_MULTIPLE_MODAL);
			mListView.setMultiChoiceModeListener(mVpnProfileSelected);
		}
		return view;
	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		Bundle args = getArguments();
		if (args != null) {
			mReadOnly = args.getBoolean("read_only", mReadOnly);
		}

		if (!mReadOnly) {
			setHasOptionsMenu(true);
		}

		Context context = getActivity().getApplicationContext();

		mDataSource = new VpnProfileDataSource(this.getActivity());
		mDataSource.open();

		/* cached list of profiles used as backend for the ListView */
		mVpnProfiles = mDataSource.getAllVpnProfiles();
		
		//INIZIO CONTROLLO SE C'E' DEFAULT NED
		boolean defaultNEDTrovato=false;
		for (VpnProfile p : mVpnProfiles) {
			if (p.getName().equals("Default NED")) {
				defaultNEDTrovato=true;
				
				p.setGateway(intToIp(ottieniDG()));
				
				SQLiteDatabase mDatabase;
				ContentValues values = ContentValuesFromVpnProfile(p);
				long id = p.getId();
				DatabaseHelper mDbHelper = new DatabaseHelper(getActivity().getApplicationContext());
				mDatabase = mDbHelper.getWritableDatabase();
				mDatabase.update("vpnprofile", values, "_id" + " = " + id,
						null);
				
				mDataSource.updateVpnProfile(p);
			}
		}
		if (defaultNEDTrovato==false){
			//non c'è nessun default NED: quindi va creato
			VpnProfile mProfile = new VpnProfile();
			mProfile.setName("Default NED");
			mProfile.setGateway(intToIp(ottieniDG()));
			mProfile.setVpnType(VpnType.IKEV2_EAP);
			mProfile.setUsername("");
			mProfile.setPassword("");
			mProfile.setRA(false);
			mProfile.setCertificateAlias("");
			mProfile.setUserCertificateAlias("");
			mVpnProfiles.add(mProfile);
			mDataSource.insertProfile(mProfile);
			
		}
		// FINE CONTROLLO SE C'E' DEFAULT NED
		
		mListAdapter = new VpnProfileAdapter(context,
				R.layout.profile_list_item, mVpnProfiles);
	}

	@Override
	public void onDestroy() {
		super.onDestroy();
		mDataSource.close();
	}

	@Override
	public void onAttach(Activity activity) {
		super.onAttach(activity);

		if (activity instanceof OnVpnProfileSelectedListener) {
			mListener = (OnVpnProfileSelectedListener) activity;
		}
	}

	@Override
	public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
		inflater.inflate(R.menu.profile_list, menu);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.add_profile:
			Intent connectionIntent = new Intent(getActivity(),
					VpnProfileDetailActivity.class);
			connectionIntent.putExtra("defaultNED", "false");
			startActivityForResult(connectionIntent, ADD_REQUEST);
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

	@Override
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		switch (requestCode) {
		case ADD_REQUEST:
		case EDIT_REQUEST:
			if (resultCode != Activity.RESULT_OK) {
				return;
			}
			long id = data.getLongExtra(VpnProfileDataSource.KEY_ID, 0);
			VpnProfile profile = mDataSource.getVpnProfile(id);
			if (profile != null) { /*
									 * in case this was an edit, we remove it
									 * first
									 */
				mVpnProfiles.remove(profile);
				mVpnProfiles.add(profile);
				mListAdapter.notifyDataSetChanged();
			}
			return;
		}
		super.onActivityResult(requestCode, resultCode, data);
	}

	private final OnItemClickListener mVpnProfileClicked = new OnItemClickListener() {
		// quando viene cliccato un NED della lista
		@Override
		public void onItemClick(AdapterView<?> a, View v, int position, long id) {
			if (mListener != null) {
				mListener.onVpnProfileSelected((VpnProfile) a
						.getItemAtPosition(position));
			}
		}
	};

	private final MultiChoiceModeListener mVpnProfileSelected = new MultiChoiceModeListener() {
		private HashSet<Integer> mSelected;
		private MenuItem mEditProfile;

		@Override
		public boolean onPrepareActionMode(ActionMode mode, Menu menu) {
			return false;
		}

		@Override
		public void onDestroyActionMode(ActionMode mode) {
		}

		@Override
		public boolean onCreateActionMode(ActionMode mode, Menu menu) {
			MenuInflater inflater = mode.getMenuInflater();
			inflater.inflate(R.menu.profile_list_context, menu);

			mEditProfile = menu.findItem(R.id.edit_profile);
			mSelected = new HashSet<Integer>();
			mode.setTitle(R.string.select_profiles);

			return true;
		}

		@Override
		public boolean onActionItemClicked(ActionMode mode, MenuItem item) {
			switch (item.getItemId()) {
			case R.id.edit_profile: {
				int position = mSelected.iterator().next();
				VpnProfile profile = (VpnProfile) mListView
						.getItemAtPosition(position);
				Intent connectionIntent = new Intent(getActivity(),
						VpnProfileDetailActivity.class);
				connectionIntent.putExtra(VpnProfileDataSource.KEY_ID,
						profile.getId());
				// connectionIntent.putExtra("defaultNED","false");
				startActivityForResult(connectionIntent, EDIT_REQUEST);
				break;
			}
			case R.id.delete_profile: {
				ArrayList<VpnProfile> profiles = new ArrayList<VpnProfile>();
				for (int position : mSelected) {
					profiles.add((VpnProfile) mListView
							.getItemAtPosition(position));
				}
				for (VpnProfile profile : profiles) {
					if (profile.getName().equals("Default NED")) {
						// se è default non lo faccio cancellare
						AlertDialog.Builder builder = new AlertDialog.Builder(
								getActivity());
						builder.setMessage("You can not delete default NED")
								.setTitle("Action forbidden");

						AlertDialog dialog = builder.create();
						dialog.show();
					} else {

						mDataSource.deleteVpnProfile(profile);
						mVpnProfiles.remove(profile);
					}
				}
				mListAdapter.notifyDataSetChanged();
				Toast.makeText(VpnProfileListFragment.this.getActivity(),
						R.string.profiles_deleted, Toast.LENGTH_SHORT).show();
				break;
			}
			default:
				return false;
			}
			mode.finish();
			return true;
		}

		@Override
		public void onItemCheckedStateChanged(ActionMode mode, int position,
				long id, boolean checked) {
			if (checked) {
				mSelected.add(position);
			} else {
				mSelected.remove(position);
			}
			final int checkedCount = mSelected.size();
			mEditProfile.setEnabled(checkedCount == 1);
			switch (checkedCount) {
			case 0:
				mode.setSubtitle(R.string.no_profile_selected);
				break;
			case 1:
				mode.setSubtitle(R.string.one_profile_selected);
				break;
			default:
				mode.setSubtitle(String.format(
						getString(R.string.x_profiles_selected), checkedCount));
				break;
			}
		}
		
		
	};
	public int ottieniDG() {
		final WifiManager manager = (WifiManager) super
				.getActivity().getSystemService(android.content.Context.WIFI_SERVICE);
		final DhcpInfo dhcp = manager.getDhcpInfo();
		return dhcp.gateway;
	}

	public String intToIp(int addr) {
		// trasformo intero in stringa IP
		return ((addr & 0xFF) + "." + ((addr >>>= 8) & 0xFF) + "."
				+ ((addr >>>= 8) & 0xFF) + "." + ((addr >>>= 8) & 0xFF));
	}
	
	private ContentValues ContentValuesFromVpnProfile(VpnProfile profile) {
		ContentValues values = new ContentValues();
		values.put(VpnProfileDataSource.KEY_NAME, profile.getName());
		values.put(VpnProfileDataSource.KEY_GATEWAY, profile.getGateway());
		values.put(VpnProfileDataSource.KEY_VPN_TYPE, profile.getVpnType().getIdentifier());
		values.put(VpnProfileDataSource.KEY_USERNAME, profile.getUsername());
		values.put(VpnProfileDataSource.KEY_PASSWORD, profile.getPassword());
		values.put(VpnProfileDataSource.KEY_CERTIFICATE, profile.getCertificateAlias());
		values.put(VpnProfileDataSource.KEY_USER_CERTIFICATE, profile.getUserCertificateAlias());
		if (profile.getRA()==true) values.put(VpnProfileDataSource.KEY_REMOTE_ATTESTATION, "TRUE");
		else values.put(VpnProfileDataSource.KEY_REMOTE_ATTESTATION, "FALSE");
		return values;
	}
	
	private static class DatabaseHelper extends SQLiteOpenHelper {
		public DatabaseHelper(Context context) {
			super(context, DATABASE_NAME, null, DATABASE_VERSION);
		}

		@Override
		public void onCreate(SQLiteDatabase database) {
			database.execSQL(VpnProfileDataSource.DATABASE_CREATE);
		}

		@Override
		public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
			Log.w(TAG, "Upgrading database from version " + oldVersion + " to "
					+ newVersion);
			if (oldVersion < 2) {
				db.execSQL("ALTER TABLE " + TABLE_VPNPROFILE + " ADD "
						+ VpnProfileDataSource.KEY_USER_CERTIFICATE + " TEXT;");
			}
			if (oldVersion < 3) {
				db.execSQL("ALTER TABLE " + TABLE_VPNPROFILE + " ADD "
						+ VpnProfileDataSource.KEY_VPN_TYPE + " TEXT DEFAULT '';");
			}
			if (oldVersion < 4) { /*
								 * remove NOT NULL constraint from username
								 * column
								 */
				updateColumns(db);
			}
		}

		private void updateColumns(SQLiteDatabase db) {
			db.beginTransaction();
			try {
				db.execSQL("ALTER TABLE " + TABLE_VPNPROFILE
						+ " RENAME TO tmp_" + TABLE_VPNPROFILE + ";");
				db.execSQL(VpnProfileDataSource.DATABASE_CREATE);
				StringBuilder insert = new StringBuilder("INSERT INTO "
						+ TABLE_VPNPROFILE + " SELECT ");
				SQLiteQueryBuilder.appendColumns(insert, ALL_COLUMNS);
				db.execSQL(insert.append(" FROM tmp_" + TABLE_VPNPROFILE + ";")
						.toString());
				db.execSQL("DROP TABLE tmp_" + TABLE_VPNPROFILE + ";");
				db.setTransactionSuccessful();
			} finally {
				db.endTransaction();
			}
		}
	}
	
}
