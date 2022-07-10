# Helm chart repository

I took [technosophos/tscharts](https://github.com/technosophos/tscharts) as reference 
to host the charts I developed via GitHub pages.

> :warning: If you need your own helm chart repo, **do not use this repository as an example**.
Use [this](https://github.com/helm/chart-releaser-action) instead.  
(I have to migrate this one some time)

:warning: **Deprecation Notice:** I stopped maintaining most of the charts in this repo, since better versions of them became available over time. Please check the README for each chart before starting to use them.

## How to use the repository

Simply run:
```bash
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
```
and start browsing and installing them:
```bash
$ helm search repo utkuozdemir
NAME                             	CHART VERSION	APP VERSION	DESCRIPTION
utkuozdemir/transmission-exporter	0.1.0        	0.3.0      	Transmission Exporter
...
$ helm install transmission-exporter utkuozdemir/transmission-exporter --version 0.1.0
NAME: transmission-exporter
LAST DEPLOYED: Tue Apr 21 00:47:10 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
...
```

## How to add a chart

In the project root

1. Package the chart
```bash
$ helm package transmission-exporter
```

2. Put the packaged chart under `docs/`.
```bash
mv transmission-exporter-0.1.0.tgz docs
```

3. Re-index the charts in the `docs/` directory
```bash
$ helm repo index docs --url https://utkuozdemir.org/helm-charts
```

4. Add both files, commit, push:
```bash
$ git add --all
$ git commit -m "Release transmission-exporter v0.1.0"
$ git push
```
