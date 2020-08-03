# jellyfin

This is a helm chart for the [Jellyfin Media Server](https://jellyfin.org/) based on the
[linuxserver.io's Jellyfin docker image](https://hub.docker.com/r/linuxserver/jellyfin).

## TL;DR;

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/jellyfin
```

## Introduction

This chart simply maps the features of the jellyfin project to the Kubernetes concepts.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/jellyfin
```

**Important:** See the [Parameters](#parameters) section lists the parameters that need to be configured 
during the installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following tables lists the configurable parameters of the chart and their default values.

| Parameter | Description | Default |
| --------- | ----------- | ------- |
| `global.storageClass` | Global storage class for dynamic provisioning | `nil` |
| `image.repository` | container image name | `haugene/jellyfin` |
| `image.pullPolicy` | container image pull policy | `IfNotPresent` |
| `image.tag` | container image tag | `{TAG_NAME}` (taken from the chart appVersion) |
| `imagePullSecrets` | Array of imagePullSecrets in the namespace for pulling images | `[]` |
| `nameOverride` | String to partially override the fullname template with a string (will prepend the release name) | `nil` |
| `fullnameOverride` | String to fully override the fullname template with a string | `nil` |
| `serviceAccount.create` | Specifies whether a ServiceAccount should be created | `true` |
| `serviceAccount.name` | The name of the ServiceAccount to create | Generated using the fullname template |
| `serviceAccount.annotations` | Annotations for the ServiceAccount | `{}` |
| `podSecurityContext` | The security context for the pods | `{}` |
| `securityContext` | The security context for the application container. Includes `NET_ADMIN` by default for the OpenVPN connection to work | `{"capabilities":{"add":["NET_ADMIN"]}}` |
| `service.type` | Kubernetes Service type | `ClusterIP` |
| `service.port` | Kubernetes Service port | `80` |
| `ingress.enabled` | Enable the use of the ingress controller to access the web UI | `false` |
| `ingress.annotations` | Annotations for the Ingress | `{}` |
| `ingress.hosts[0].host` | Hostname to your installation | `chart-example.local` |
| `ingress.hosts[0].paths` | Path within the url structure | `[]` |
| `ingress.tls` | The TLS configuration for the ingress | `[]` |
| `resources` | The resources to allocate for the container | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Tolerations for pod assignment | `[]` |
| `affinity` | Map of node/pod affinities | `{}` |
| `persistence.config.enabled` | Enable persistence for config storage | `false` |
| `persistence.config.storageClass` | Specify the `storageClass` used to provision the config volume | `nil` |
| `persistence.config.existingClaim` | Use a existing PVC for config which must be created manually before bound | `nil` |
| `persistence.config.annotations` | Annotations for the config volume PVC | `nil` |
| `persistence.config.accessModes` | Access modes of config volume | `["ReadWriteOnce"]` |
| `persistence.config.size` | Size for the config PV | `8Gi` |
| `persistence.data.enabled` | Enable persistence for data storage | `false` |
| `persistence.data.storageClass` | Specify the `storageClass` used to provision the data volume | `nil` |
| `persistence.data.existingClaim` | Use a existing PVC for data which must be created manually before bound | `nil` |
| `persistence.data.annotations` | Annotations for the data volume PVC | `nil` |
| `persistence.data.accessModes` | Access modes of data volume | `["ReadWriteOnce"]` |
| `persistence.data.size` | Size for the data PV | `8Gi` |
| `jellyfin.timezone` | Timezone to be used. See https://en.wikipedia.org/wiki/List_of_tz_database_time_zones | `nil` |
| `jellyfin.uid` | The unix user id for the process to run with | `nil` |
| `jellyfin.gid` | The unix group id for the process to run with | `nil` |
| `jellyfin.otherEnv` | Additional key-value pairs to be passed as environment variables to the container. See https://hub.docker.com/r/linuxserver/jellyfin for reference | `nil` |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set persistence.config.enabled=true \
  --set persistence.data.enabled=true \
  --set persistence.data.size=1Ti \
  --set jellyfin.timezone=Europe/Berlin \
  utkuozdemir/jellyfin
```

The above command enabled persistence for both config and data, sets the data PVC (library) size 
to 1 terabyte and uses the Berlin/Germany timezone.

Alternatively, a YAML file that specifies the values for the parameters 
can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml utkuozdemir/jellyfin
```

> **Tip**: You can use the default [values.yaml](values.yaml)
