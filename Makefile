# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all:
	mkdir --parents $(PWD)/build
	mkdir --parents $(PWD)/build/AppDir
	mkdir --parents $(PWD)/build/AppDir/turtl

	wget --output-document=$(PWD)/build/build.tar.bz2 https://github.com/turtl/desktop/releases/download/v0.7.2.5/turtl-0.7.2.5-linux64.tar.bz2
	tar -xf $(PWD)/build/build.tar.bz2 -C $(PWD)/build/

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/gtk2-2.24.32-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/GConf2-3.2.6-22.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	cp --force --recursive $(PWD)/build/usr/* $(PWD)/build/AppDir/
	cp --force --recursive $(PWD)/build/turtl-linux64/turtl/* $(PWD)/build/AppDir/turtl
	cp --force --recursive $(PWD)/AppDir/* $(PWD)/build/AppDir

	chmod +x $(PWD)/build/AppDir/AppRun
	chmod +x $(PWD)/build/AppDir/*.desktop

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/AppDir $(PWD)/Turtl.AppImage
	chmod +x $(PWD)/Turtl.AppImage

clean:
	rm -rf $(PWD)/build
