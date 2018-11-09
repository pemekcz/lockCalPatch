Name:          lockscreen-upcoming
Version:       0.8
Release:       1
Summary:       Lock screen patch
Group:         System/Patches
Vendor:        Anant Gajjar
Distribution:  SailfishOS
Packager: Anant Gajjar
License:       GPL
Requires: patchmanager
Requires: sailfish-version >= 3.0
BuildArch: noarch

%description
This is a patch for the lockscreen to show the upcoming events. The view is fully configurable using the settings.

%files
/usr/share/patchmanager/patches/*
/usr/share/lipstick-jolla-home-qt5/lockscreen/*
/usr/share/jolla-settings/entries/*
/usr/share/jolla-settings/pages/*

%defattr(-,root,root,-)


%post
%preun
    // Do stuff specific to uninstalls
if [ -f /usr/sbin/patchmanager ]; then
/usr/sbin/patchmanager -u lockscreen-upcoming || true
fi

%postun
if [ $1 = 0 ]; then
    // Do stuff specific to uninstalls
dconf reset -f /desktop/lipstick-jolla-home/lockscreenUpcoming/ || true
rm -rf /usr/share/patchmanager/patches/lockscreen-upcoming || true
rm -rf /usr/share/jolla-settings/pages/lockscreen-upcoming-patch || true
rm -rf /usr/share/jolla-settings/entries/lockscreen-upcoming-patch.json || true 
else
if [ $1 = 1 ]; then
    // Do stuff specific to upgrades
echo "It's just upgrade"
fi
fi

%changelog
*  Mon Sep 21 2015 Builder <builder@...>
0.8
- Compatible with Sailfish 3.0
0 7
- Bug fix - content not scrolling and out of frame (https://github.com/anigaj/lockCalPatch/issues/2)
0.6
- Implemented setting to change position
- Additional required files are now installed rather than patched
0.5
- Stop animations on lockscreen exit (Thanks Ajalkane for the code contributed)
- Built with noarch
0.4
- Compatible with sailfish version 1.1.9.28
- Added scrolling text for long event names
0.3
- Added message for no events, option to show is in settings
- Fixed bug where finished event would not be removed
- Duplicate events issue fully fixed
- Width is now fraction of screen width for use on non-jolla phones
- Updated uninstall scripts and added dependencies
- Resolve conflict with battery and status indicators on lockscreen patch 
0.2
- Added settings
- Fixed duplicate event issue 
0.1
- First build.
