Name:          lockscreen-upcoming
Version:       0.2
Release:       1
Summary:       Lock screen patch
Group:         System/Patches
Vendor:        Anant Gajjar
Distribution:  SailfishOS
Packager: Anant Gajjar
License:       GPL

%description
This is a patch for the lockscreen to show the upcoming events for the next seven days.

%files
/usr/share/patchmanager/patches/*
/usr/share/jolla-settings/entries/*
/usr/share/jolla-settings/pages/*

%defattr(-,root,root,-)


%post
%preun
    // Do stuff specific to uninstalls
patchmanager -u lockscreen-upcoming

%postun
if [ $1 = 0 ]; then
    // Do stuff specific to uninstalls
dconf reset -f /desktop/lipstick-jolla-home/lockscreenUpcoming/
rm -rf /usr/share/patchmanager/patches/lockscreen-upcoming
rm -rf /usr/share/jolla-settings/pages/lockscreen-upcoming-patch
rm -rf /usr/share/jolla-settings/entries/lockscreen-upcoming-patch.json 
else
if [ $1 = 1 ]; then
    // Do stuff specific to upgrades
echo "It's just upgrade"
fi
fi

%changelog
*  Mon Aug 03 2015 Builder <builder@...>
0.2
- Added settings
- Fixed duplicate event issue 
0.1
- First build.
