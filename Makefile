SOURCE="https://github.com/turtl/desktop/releases/download/v0.7.2.5/turtl-0.7.2.5-linux64.tar.bz2"
DESTINATION="turtl.tar.bz2"
OUTPUT="Turtl.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION) -c $(SOURCE)

	tar -xf $(DESTINATION)
#	rm -rf AppDir/application
	
	mkdir --parents AppDir/application
	cp -r turtl-linux64/turtl/* AppDir/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf AppDir/application
	rm -rf turtl-linux64
