%undefine _hardened_build
%define _gprdir %_GNAT_project_dir
%define rtl_version 0.1

Name:       webdriver
Version:    0.1.0
Release:    git%{?dist}
Summary:    Ada binding to WebDriver API
Group:      Development/Libraries
License:    MIT
URL:        https://github.com/reznikmm/webdriver
### Direct download is not availeble
Source0:    webdriver.tar.gz
BuildRequires:   gcc-gnat
BuildRequires:   fedora-gnat-project-common  >= 3
BuildRequires:   matreshka-devel
BuildRequires:   aws-devel
BuildRequires:   gprbuild

# gprbuild only available on these:
ExclusiveArch: %GPRbuild_arches

%description
Webdriver is a remote control interface that enables introspection and
control of user agents. It provides a platform- and language-neutral wire
protocol as a way for out-of-process programs to remotely instruct the
behavior of web browsers.

This project is an Ada library to work WebDriver. Currently it's been
tested with ChromeDriver.

%package devel

Group:      Development/Libraries
License:    MIT
Summary:    Devel package for Ada Pretty
Requires:       %{name}%{?_isa} = %{version}-%{release}
Requires:   fedora-gnat-project-common  >= 2

%description devel
Devel package for webdriver

%prep
%setup -q -n %{name}

%build
make  %{?_smp_mflags} GPRBUILD_FLAGS="%Gnatmake_optflags"

%install
rm -rf %{buildroot}
make install DESTDIR=%{buildroot} LIBDIR=%{_libdir} PREFIX=%{_prefix} GPRDIR=%{_gprdir} BINDIR=%{_bindir}

%check
make  %{?_smp_mflags} GPRBUILD_FLAGS="%Gnatmake_optflags" check

%files
%doc LICENSE
%dir %{_libdir}/%{name}
%{_libdir}/%{name}/libwebdriver.so.%{rtl_version}
%{_libdir}/libwebdriver.so.%{rtl_version}
%{_libdir}/%{name}/libwebdriver.so.0
%{_libdir}/libwebdriver.so.0
%files devel
%doc README.md
%{_libdir}/%{name}/libwebdriver.so
%{_libdir}/libwebdriver.so
%{_libdir}/%{name}/*.ali
%{_includedir}/%{name}
%{_gprdir}/webdriver.gpr
%{_gprdir}/manifests/webdriver


%changelog
* Sat Feb 22 2020 Maxim Reznik <reznikmm@gmail.com> - 0.1.0-git
- Initial package
