package org.strongswan.android.netgroup.secured;


import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.DatagramChannel;

import org.strongswan.android.R;

import android.app.PendingIntent;
import android.content.Intent;
import android.net.VpnService;
import android.os.Handler;
import android.os.Message;
import android.os.ParcelFileDescriptor;
import android.util.Log;
import android.widget.Toast;


public class my_firewall_service extends VpnService implements Handler.Callback, Runnable {
    private static final String TAG = "Firewall_VpnService";

    private String mServerAddress= "127.0.0.1";
    private int  mServerPort= 55555;
    private PendingIntent mConfigureIntent;

    private Handler mHandler;
    private Thread mThread;

    private ParcelFileDescriptor mInterface;

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // The handler is only used to show messages.
        if (mHandler == null) {
            mHandler = new Handler(this);
        }

        // Stop the previous session by interrupting the thread.
        if (mThread != null) {
            mThread.interrupt();
        }

        // Start a new session by creating a new thread.
        mThread = new Thread(this, "FirewallThread");
        mThread.start();
        return START_STICKY;
    }

    @Override
    public void onDestroy() {
        if (mThread != null) {
            mThread.interrupt();
        }
    }

    @Override
    public boolean handleMessage(Message message) {
        if (message != null) {
        	Toast.makeText(this, "Locked!", Toast.LENGTH_SHORT).show();
        }
        return true;
    }

    @Override
    public synchronized void run() {
        try {
            Log.i(TAG, "Starting");

             
            InetSocketAddress server = new InetSocketAddress(
                    mServerAddress, mServerPort);

            run(server);
            
        } catch (Exception e) {
        
        	Log.e(TAG, "Got " + e.toString());
        
        
            try {
                mInterface.close();
            } catch (Exception e2) {
                // ignore
            }
            mInterface = null;

            mHandler.sendEmptyMessage(R.string.disconnected);
            Log.i(TAG, "Exiting");
        
        }
    }
        
     
	
    DatagramChannel mTunnel = null;

    private boolean run(InetSocketAddress server) throws Exception {
        
        boolean connected = false;
      
            // Create a DatagramChannel as the VPN tunnel.
        	// Creates an opened and not-connected datagram channel.
            mTunnel = DatagramChannel.open();

            // Protect the tunnel before connecting to avoid loopback.
            /* public boolean protect (int socket); 
             * Protect a socket from VPN connections. The socket will be bound 
             * to the current default network interface, so its traffic will 
             * not be forwarded through VPN. This method is useful if some 
             * connections need to be kept outside of VPN. For example, a VPN 
             * tunnel should protect itself if its destination is covered by 
             * VPN routes. Otherwise its outgoing packets will be sent back to 
             * the VPN interface and cause an infinite loop. This method will 
             * fail if the application is not prepared or is revoked. 
             * 
             * The socket is NOT closed by this method.
             * */
            
            if (!protect(mTunnel.socket())) {
                throw new IllegalStateException("Cannot protect the tunnel");
            }

            // Connect to the server.
            mTunnel.connect(server);

            /* public final SelectableChannel configureBlocking (boolean blockingMode);
             * Sets the blocking mode of this channel:
             * Parameters:
					blockingMode	true for setting this channel's mode to blocking, 
									false to set it to non-blocking.
			 * Returns:
			    	this channel.
			  
			 * Throws:
					ClosedChannelException	if this channel is closed.
					IllegalBlockingModeException	if block is true and this channel has been registered with at least one selector.
					IOException	if an I/O error occurs.
            */
            // For simplicity, we use the same thread for both reading and
            // writing. Here we put the tunnel into non-blocking mode.
            mTunnel.configureBlocking(false);

            // Authenticate and configure the virtual network interface.
            configure();

            // Now we are connected. Set the flag and show the message.
            connected = true;
            mHandler.sendEmptyMessage(R.string.connected);

            new Thread ()
            {
                public void run ()
                    {
                        // Packets to be sent are queued in this input stream.
                        FileInputStream in = new FileInputStream(mInterface.getFileDescriptor());
                        // Allocate the buffer for a single packet.
                        ByteBuffer packet = ByteBuffer.allocate(32767);
                        int length;
                        try
                        {
                            while (true)
                            {
                                while ((length = in.read(packet.array())) > 0) {
                                        // Write the outgoing packet to the tunnel.
                                        packet.limit(length);
                                        //debugPacket(packet);    // Packet size, Protocol, source, destination
                                       
                                        packet.clear();

                                    }
                                }
                        }
                        catch (IOException e)
                        {
                                e.printStackTrace();
                        }

                }
            }.start();
            
            
            
            new Thread ()
            {

                public void run ()
                {
                        DatagramChannel tunnel = mTunnel;
                        // Allocate the buffer for a single packet.
                        ByteBuffer packet = ByteBuffer.allocate(8096);
                        // Packets received need to be written to this output stream.
                        FileOutputStream out = new FileOutputStream(mInterface.getFileDescriptor());

                        while (true)
                        {
                            try
                            {
                                // Read the incoming packet from the tunnel.
                                int length;
                                while ((length = tunnel.read(packet)) > 0)
                                {
                                    packet.limit(length);

                                        // Write the incoming packet to the output stream.
                                    //out.write(packet.array(), 0, length);

                                    packet.clear();

                                }
                            }
                            catch (IOException ioe)
                            {
                                    ioe.printStackTrace();
                            }
                        }
                }
            }.start();
            
            
        return connected;
    }

    
    private void configure() throws Exception {
        
    	// If the old interface has exactly the same parameters, use it!
        if (mInterface != null ) {
            Log.i(TAG, "Using the previous interface");
            return;
        }

        // Configure a builder ( android.net.VpnService.Builder.Builder())
        //while parsing the parameters.
        Builder builder = new Builder();
        builder.setMtu(1500);
        builder.addAddress("10.0.0.5",30);
        builder.addRoute("0.0.0.0", 0);
        
        // Close the old interface since the parameters have been changed.
        try {
            mInterface.close();
        } catch (Exception e) {
            // ignore
        }

        // Create a new interface using the builder and save the parameters.
        mInterface = builder.setSession("Firewall Vpn")
                .setConfigureIntent(mConfigureIntent)
                .establish();
     }
    
}