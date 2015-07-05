Name:          lockscreen-upcoming
Version:       0.1
Release:       1
Summary:       Lock screen patch
Group:         System/Patches
Vendor:        Anant Gajjar
Distribution:  SailfisfOS
Packager: Anant Gajjar
License:       GPL

%description
This is a patch for the lockscreen to show the upcoming events for the next seven days.

%files
/usr/share/patchmanager/patches/*

%defattr(-,root,root,-)


%post
%preun
    // Do stuff specific to uninstalls
patchmanager -u lockscreen-upcoming

%postun
if [ $1 = 0 ]; then
    // Do stuff specific to uninstalls
rm -rf /usr/share/patchmanager/patches/lockscteen-upcoming
else
if [ $1 = 1 ]; then
    // Do stuff specific to upgrades
echo "It's just upgrade"
fi
fi

%changelog
*  Fri Jul 03 2015 Builder <builder@...> 
0.1
- First build.
