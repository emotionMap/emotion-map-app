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

gen:
	@source .env.script && \
	fvm dart run openapi_generator_cli:main generate \
	-g dart-dio \
	--global-property apis \
	--global-property apiDocs=false \
	--global-property apiTests=false \
	--global-property models \
	--global-property modelDocs=false \
	--global-property modelTests=false \
	--additional-properties serializationLibrary=json_serializable \
	--additional-properties sourceFolder=generate \
	--additional-properties pubName=emotion_map_app \
	--additional-properties finalProperties=false \
	-t ./mustaches \
	-i $$SWAGGER_URL && \
	fvm dart format ./lib/generate/**/*.dart