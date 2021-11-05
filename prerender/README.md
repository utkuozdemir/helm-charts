# prerender

[Prerender](https://github.com/prerender/prerender) is a node server that uses 
Headless Chrome to render HTML, screenshots, PDFs, and HAR files out of any web page.

## TL;DR

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/prerender
```

## Introduction

This Helm chart simply wraps the Docker image 
[tvanro/prerender-alpine](https://github.com/tvanro/prerender-alpine).

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/prerender
```

These commands deploy prerender in the default configuration.
The [Parameters](#parameters) section lists the parameters
that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` release:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

| Key | Description | Default |
|-----|------|---------|
| `image.repository` | Image repository | `"docker.io/tvanro/prerender-alpine"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
| `image.tag` | Image tag (if not specified, defaults to the chart's appVersion) | `""` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `nameOverride` | String to partially override prerender.fullname template with a string (will prepend the release name) | `""` |
| `fullnameOverride` | String to fully override prerender.fullname template with a string | `""` |
| `serviceAccount.create` | Create a service account | `true` |
| `serviceAccount.annotations` | Annotations for the service account | `{}` |
| `serviceAccount.name` | The name of the service account to create | `""` |
| `service.type` | Type of the service | `"ClusterIP"` |
| `service.annotations` | Annotations for the service | `{}` |
| `ingress.enabled` | Enable the use of the ingress controller | `false` |
| `ingress.className` | Class name for the ingress | `{}` |
| `ingress.annotations` | Annotations for the ingress | `{}` |
| `ingress.hosts` | Hosts configuration of the ingress | see [values.yaml](values.yaml) |
| `ingress.tls` | The TLS configuration for the ingress | `[]` |
| `replicaCount` | Pod replica count (if autoscaling is not enabled) | `1` |
| `autoscaling.enabled` | Enable autoscaling | `false`                                                      |
| `autoscaling.minReplicas` | Minimum number of replicas when autoscaling is enabled | `1`                                                          |
| `autoscaling.maxReplicas` | Maximum number of replicas when autoscaling is enabled | `10`                                                         |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage when autoscaling is enabled | `80`                                                        |
| `autoscaling.targetMemoryUtilizationPercentage` | Target memory utilization percentage when autoscaling is enabled | `nil`
| `resources` | The resource requests and limits of the container | `{}` |
| `podAnnotations` | Annotations for the pod | `{}` |
| `podSecurityContext` | Security context for the pod | `{}` |
| `securityContext` | Security context for the container | `{}` |
| `nodeSelector` | The node selector for the deployment | `{}` |
| `tolerations` | Tolerations for the pod assignment | `[]` |
| `affinity` | Affinity for the pod assignment | `{}` |
| `env` | The env variable key-value pairs to be passed to the pod | `{"NODE_ENV":"production"}` |

The above config parameters map to the various configuration env variables of a typical prerender server.

For more information please refer to the
[project repository](https://github.com/prerender/prerender) 
and the [Docker image project repository](https://github.com/tvanro/prerender-alpine).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install my-release \
    --set env.CACHE_MAXSIZE=2000 \
    utkuozdemir/prerender
```

Alternatively, a YAML file that specifies the values for the above parameters
can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml utkuozdemir/prerender
```

> **Tip**: You can use the default [values.yaml](values.yaml)
