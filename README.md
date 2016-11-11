# SECURED App #

## Compile instructions ##

Create a symlink from src/frontends/android/jni to the root of the repository, for example in this way:

    ln -s src/frontends/android/jni strongswan

In src/frontends/android/jni create a folder "openssl" and download inside it the sources for a version of OpenSSL specially prepared for the build within the Android NDK. You can use this command:

    git clone git://git.strongswan.org/android-ndk-openssl.git -b ndk-static openssl

If you will use Eclipse with the ADT-plugin, you must first build the native parts. To do it, change directory to src/frontends/android/jni and launch the command:

    /path/to/ndk/root/ndk-build

This one must be the path where you downloaded the ndk-build package from Google.

To build the App a new project has to be created in Eclipse (New -> Project -> Android Project from Existing Code). If a symlink is used for the jni/strongswan directory it takes a while for the ADT plugin to load the available projects after src/frontends/android has been selected. That's because it will recursively traverse into the strongswan directory, so either remove the symlink before creating the project or wait and just deselect every found project but the first one.

The App will then be built automatically (or can be built via Project -> Build Project). If anything is changed in the native parts, ndk-build can be used to rebuild them. It is recommended that Project -> Clean... is used in Eclipse afterwards to force it to load the new libraries and rebuild the App.

Vice versa, if you use Android Studio, you can avoid this last steps, building the project directly from Android Studio. The directory src/frontends/android can directly be opened as existing project in Android Studio. The initial build will fail if the NDK directory is not known. In that case set it via File - Project Structure... or manually in local.properties (ndk.dir=/path/to/ndk). Afterwards the build should be successful.

## Testing instructions ##

At today (Oct 30, 2015) a NED with a public address is available for testing the SecuredApp:

    NED IP address: 130.192.225.238
    Verifier IP address: 130.192.225.173
    username (ipsec/strongswan): fulvio
    password (ipsec/strongswan): fulvio
    
