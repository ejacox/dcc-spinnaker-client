build:
	docker build -t robcurrie/dcc-uploader .

push:
	docker push robcurrie/dcc-uploader

upload:
	sudo rm -rf outputs
	docker run -it --rm \
		-v `pwd`/manifests:/manifests \
		-v `pwd`/samples:/samples \
		-v `pwd`/outputs:/outputs \
		--link spinnaker:spinnaker \
		robcurrie/dcc-uploader \
		--storage-access-token $(UCSC_DCC_TOKEN) \
		--submission-server-url http://spinnaker:5000 \
		--force-upload \
		/manifests/two_manifest.tsv

skip_submit:
	sudo rm -rf outputs
	docker run -it --rm \
		-v `pwd`/manifests:/manifests \
		-v `pwd`/samples:/samples \
		-v `pwd`/outputs:/outputs \
		robcurrie/dcc-uploader \
		--storage-access-token $(UCSC_DCC_TOKEN) \
		--force-upload \
		--skip-submit \
		/manifests/two_manifest.tsv

debug:
	docker run -it --rm --entrypoint=/bin/sh \
		-v `pwd`/manifests:/manifests \
		-v `pwd`/samples:/samples \
		-v `pwd`/outputs:/outputs \
		--link spinnaker:spinnaker \
		robcurrie/dcc-uploader