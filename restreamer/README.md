# Restreamer

This is a helm chart for the 
[datarhei/restreamer](https://github.com/datarhei/restreamer) image.

## TL;DR;

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/restreamer
```

## Introduction

This chart simply maps the features of the Restreamer project to the Kubernetes concepts.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/restreamer
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
| `image.repository` | container image name | `datarhei/restreamer` |
| `image.pullPolicy` | container image pull policy | `IfNotPresent` |
| `image.tag` | container image tag | `{TAG_NAME}` (taken from the chart appVersion) |
| `imagePullSecrets` | Array of imagePullSecrets in the namespace for pulling images | `[]` |
| `nameOverride` | String to partially override the fullname template with a string (will prepend the release name) | `nil` |
| `fullnameOverride` | String to fully override the fullname template with a string | `nil` |
| `serviceAccount.create` | Specifies whether a ServiceAccount should be created | `true` |
| `serviceAccount.name` | The name of the ServiceAccount to create | Generated using the fullname template |
| `serviceAccount.annotations` | Annotations for the ServiceAccount | `{}` |
| `podSecurityContext` | The security context for the pods | `{}` |
| `securityContext` | The security context for the application container. | `{}` |
| `service.type` | Kubernetes Service type | `ClusterIP` |
| `service.port` | Kubernetes Service port | `80` |
| `service.annotations` | Annotations for the Service | `{}` |
| `ingress.enabled` | Enable the use of the ingress controller | `false` |
| `ingress.className` | Class name for the ingress | `{}` |
| `ingress.annotations` | Annotations for the ingress | `{}` |
| `ingress.hosts` | Hosts configuration of the ingress | see [values.yaml](values.yaml) |
| `ingress.tls` | The TLS configuration for the ingress | `[]` |
| `resources` | The resources to allocate for the container | `{}` |
| `affinity` | Map of node/pod affinities | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Tolerations for pod assignment | `[]` |
| `persistence.enabled` | Enable persistence | `false` |
| `persistence.existingClaim` | Use a existing PVC which must be created manually before bound | `nil` |
| `persistence.storageClass` | Specify the `storageClass` used to provision the volume | `nil` |
| `persistence.accessModes` | Access modes of data volume  | `["ReadWriteOnce"]` |
| `persistence.size` | Size for the PV | `512Mi` |
| `env` | The **non-sensitive** environment variables to configure the application. See the possible configuration here: https://datarhei.github.io/restreamer/docs/references-environment-vars.html | See `values.yaml` |
| `secretEnv` | The **sensitive** environment variables to configure the application. See the possible configuration here: https://datarhei.github.io/restreamer/docs/references-environment-vars.html | See `values.yaml` |
| `rtmp.hostPort.enabled` | If the RTMP should be exposed from a hostPort or not | `false` |
| `rtmp.hostPort.port` | The hostPort to expose RTMP from | `1935` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set secretEnv.RS_USERNAME=myusername \
  --set secretEnv.RS_PASSWORD=mypassword \
  utkuozdemir/restreamer
```

Alternatively, a YAML file that specifies the values for the parameters 
can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml utkuozdemir/restreamer
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Notes

For more information, see the 
[datarhei/restreamer](https://github.com/datarhei/restreamer) project.
