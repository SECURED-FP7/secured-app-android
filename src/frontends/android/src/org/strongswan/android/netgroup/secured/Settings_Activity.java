package org.strongswan.android.netgroup.secured;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;

import org.strongswan.android.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.CompoundButton.OnCheckedChangeListener;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.Toast;

public class Settings_Activity extends Activity {
	CheckBox mCheckBlock;
	EditText editText;
	public static boolean block_traffic = leggiBloccoDaFile();
	public static String receiver = leggiReceiverDaFile();

	public static MenuItem menuItem;
	public static MenuItem favButton;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.settings_layout);
		mCheckBlock = (CheckBox) findViewById(R.id.ck_block);
		mCheckBlock.setEnabled(false);

		editText = (EditText) findViewById(R.id.edit_receiver);
		editText.setEnabled(false);


		
		
		menuItem=(MenuItem)findViewById(R.id.save_settings);


		// attach a listener to check for changes in state
		/*
		mySwitch.setOnCheckedChangeListener(new OnCheckedChangeListener() {

			@Override
			public void onCheckedChanged(CompoundButton buttonView,
					boolean isChecked) {

				if (isChecked) {
					mCheckBlock.setEnabled(true);
					editText.setEnabled(true);
					myButton.setEnabled(true);
				} else {
					mCheckBlock.setEnabled(false);
					editText.setEnabled(false);
					myButton.setEnabled(false);
				}

			}
			
		});*/

		mCheckBlock.setChecked(block_traffic);
		
		editText.setText(receiver);

	}
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater=getMenuInflater();
		
		inflater.inflate(R.menu.menu_settings, menu);
		
		favButton = menu.findItem(R.id.save_settings);
		favButton.setEnabled(false);

		return true;
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item){
		int id=item.getItemId();
		switch(id){
		case R.id.edit:
			mCheckBlock.setEnabled(true);
			editText.setEnabled(true);
			favButton.setEnabled(true);
			break;
		case R.id.save_settings:

			
				Toast.makeText(getApplication(), "Saved", Toast.LENGTH_SHORT)
						.show();

				receiver = editText.getText().toString();

				// AGGIUNTA MIA PER SCRIVERE SU FILE IL VERIFIER
				try {
					FileOutputStream prova = new FileOutputStream(
							"/data/data/org.strongswan.android/cache/receiverIP.txt",
							false);// sovrascrivo eventuale file
					PrintStream scrivi = new PrintStream(prova);
					scrivi.print(receiver);
					scrivi.close();
				} catch (IOException e) {
					System.out.println("Errore: " + e);
					System.exit(1);
				}

				// FINE AGGIUNTA MIA PER SCRIVERE SUL FILE IL VERIFIER
				
				if (mCheckBlock.isChecked()) block_traffic=true;
				else block_traffic=false;
				
				// AGGIUNTA MIA PER SCRIVERE SU FILE IL BLOCCO
				
				try {
					FileOutputStream prova = new FileOutputStream(
							"/data/data/org.strongswan.android/cache/bloccoTraffico.txt",
							false);// sovrascrivo eventuale file
					PrintStream scrivi = new PrintStream(prova);
					if (block_traffic==false) {scrivi.print("NonBlocca");}
					else scrivi.print("Blocca");
					
					scrivi.close();
				} catch (IOException e) {
					System.out.println("Errore: " + e);
					System.exit(1);
				}
				
				// FINE AGGIUNTA MIA PER SCRIVERE SUL FILE IL BLOCCO
			
				
				//ora che ho salvato, disattivo i vari controlli
				mCheckBlock.setEnabled(false);
				editText.setEnabled(false);
				favButton.setEnabled(false);
				
			break;
		}
		return false;
	}
	
	private static boolean leggiBloccoDaFile() {
		BufferedReader br;
		boolean valoreRitornato = false;
		try {
			br = new BufferedReader(new FileReader(
					"/data/data/org.strongswan.android/cache/bloccoTraffico.txt"));

			StringBuilder sb = new StringBuilder();
			String line = br.readLine();

			if (line != null) {
				sb.append(line);
				br.close();
				if (sb.toString().equals("Blocca")) valoreRitornato = true;
				else valoreRitornato=false;
			} else {
				br.close();
			}

		} catch (FileNotFoundException e1) {
			valoreRitornato = false;
		} catch (IOException e) {
			valoreRitornato = false;

		}
		return valoreRitornato;
	}
	
	
	private static String leggiReceiverDaFile() {
		BufferedReader br;
		String stringaRitornata = null;
		try {
			br = new BufferedReader(new FileReader(
					"/data/data/org.strongswan.android/cache/receiverIP.txt"));

			StringBuilder sb = new StringBuilder();
			String line = br.readLine();

			if (line != null) {
				sb.append(line);
				br.close();
				stringaRitornata = sb.toString();
			} else {
				br.close();
				// stringaRitornata = "130.192.1.86";
				stringaRitornata = "";
			}

		} catch (FileNotFoundException e1) {
			// stringaRitornata = "130.192.1.86";
			stringaRitornata = "";
		} catch (IOException e) {
			// stringaRitornata = "130.192.1.86";
			stringaRitornata = "";

		}
		return stringaRitornata;
	}

}
