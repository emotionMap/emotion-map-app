clean:
	fvm flutter clean && \
	fvm flutter pub get && \
	fvm flutter precache --ios && \
	cd ios && \
	pod install && \
	cd .. && \
	fvm flutter pub run spider build && \
	fvm flutter pub run build_runner build --delete-conflicting-outputs

watch:
	fvm flutter pub run build_runner watch --delete-conflicting-outputs

spider:
	fvm flutter pub run spider build --watch