Name:          lockscreen-upcoming
Version:       0.3
Release:       1
Summary:       Lock screen patch
Group:         System/Patches
Vendor:        Anant Gajjar
Distribution:  SailfishOS
Packager: Anant Gajjar
License:       GPL
Requires: patchmanager

%description
This is a patch for the lockscreen to show the upcoming events. The view is fully configurable using the settings.

%files
/usr/share/patchmanager/patches/*
/usr/share/jolla-settings/entries/*
/usr/share/jolla-settings/pages/*

%defattr(-,root,root,-)


%post
%preun
    // Do stuff specific to uninstalls
if [ -f /usr/sbin/patchmanager ]; then
/usr/sbin/patchmanager -u lockscreen-upcoming || true
rm -f /usr/share/lipstick-jolla-
home-qt5/lockscreen/BorderRectangle.qml || true
rm -f /usr/share/lipstick-jolla-
home-qt5/lockscreen/LockTimeLabel.qml || true
rm -f /usr/share/lipstick-jolla-
home-qt5/lockscreen/LockEventItem.qml || true
rm -f /usr/share/lipstick-jolla-
home-qt5/lockscreen/ShowCalEvents.qml || true
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
*  Fri Sep 04 2015 Builder <builder@...>
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
