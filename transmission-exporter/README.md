# transmission-exporter

This is a helm chart for the 
[metalmatze/transmission-exporter](https://github.com/metalmatze/transmission-exporter) image.

## TL;DR;

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/transmission-exporter
```

## Introduction

This chart simply maps the features of the transmission-exporter project to the Kubernetes concepts.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/transmission-exporter
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
| `image.repository` | container image name | `metalmatze/transmission-exporter` |
| `image.pullPolicy` | container image pull policy | `IfNotPresent` |
| `image.tag` | container image tag | `{TAG_NAME}` (taken from the chart appVersion) |
| `imagePullSecrets` | Array of imagePullSecrets in the namespace for pulling images | `[]` |
| `nameOverride` | String to partially override the fullname template with a string (will prepend the release name) | `nil` |
| `fullnameOverride` | String to fully override the fullname template with a string | `nil` |
| `serviceAccount.create` | Specifies whether a ServiceAccount should be created | `true` |
| `serviceAccount.name` | The name of the ServiceAccount to create | Generated using the fullname template |
| `serviceAccount.annotations` | Annotations for the ServiceAccount | `{}` |
| `podSecurityContext` | The security context for the pods | `{}` |
| `securityContext` | The security context for the application container. | `{"capabilities":{}` |
| `service.type` | Kubernetes Service type | `ClusterIP` |
| `service.port` | Kubernetes Service port | `19091` |
| `service.annotations` | Annotations for the Service | `{}` |
| `ingress.enabled` | Enable the use of the ingress controller to access the web UI | `false` |
| `ingress.annotations` | Annotations for the Ingress | `{}` |
| `ingress.hosts[0].host` | Hostname to your installation | `chart-example.local` |
| `ingress.hosts[0].paths` | Path within the url structure | `[]` |
| `ingress.tls` | The TLS configuration for the ingress | `[]` |
| `resources` | The resources to allocate for the container | `{}` |
| `affinity` | Map of node/pod affinities | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Tolerations for pod assignment | `[]` |
| `web.path` | The endpoint path for the metrics | `/metrics` |
| `web.addr` | The address for the metrics | `:19091` |
| `transmission.addr` | The address for the transmission to gather metrics from | `http://transmission:9091` |
| `transmission.username` | The username for transmission, if authentication is required | `nil` |
| `transmission.username` | The password for transmission, if authentication is required | `nil` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set transmission.addr=http://my-transmission-service:9091
  utkuozdemir/transmission-exporter
```

Alternatively, a YAML file that specifies the values for the parameters 
can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml utkuozdemir/transmission-exporter
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Notes

For more information, see the 
[metalmatze/transmission-exporter](https://github.com/metalmatze/transmission-exporter) project.
