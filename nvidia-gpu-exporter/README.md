# nvidia-gpu-exporter

> **:exclamation: This Helm Chart is deprecated!**

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.2.1](https://img.shields.io/badge/AppVersion-1.2.1-informational?style=flat-square)

DEPRECATED - the chart moved to the application repository, see https://github.com/utkuozdemir/nvidia_gpu_exporter

**Homepage:** <https://github.com/utkuozdemir/nvidia_gpu_exporter>

## This chart has moved

The chart now lives in the application repository and is maintained there as chart version 2.x:
<https://github.com/utkuozdemir/nvidia_gpu_exporter/tree/main/charts/nvidia-gpu-exporter>

Install it from its new home:

```console
$ helm install nvidia-gpu-exporter oci://ghcr.io/utkuozdemir/charts/nvidia-gpu-exporter
```

or via the classic repository:

```console
$ helm repo add nvidia-gpu-exporter https://utkuozdemir.github.io/nvidia_gpu_exporter
$ helm install nvidia-gpu-exporter nvidia-gpu-exporter/nvidia-gpu-exporter
```

The new chart accesses GPUs through the NVIDIA container runtime instead of hand-mounted host paths, so values are not compatible with this chart. See the "Upgrading from chart 1.x" section of the new chart's README before migrating.

This version of the chart receives no further updates.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for the pod assignment |
| fullnameOverride | string | `""` | String to fully override fullname template with a string |
| hostNetwork | bool | `false` |  |
| hostPort.enabled | bool | `false` | Enable hostPort |
| hostPort.port | int | `9835` | The hostPort to listen to |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"docker.io/utkuozdemir/nvidia_gpu_exporter"` | Image repository |
| image.tag | string | `""` | Image tag (if not specified, defaults to the chart's appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.annotations | object | `{}` | Annotations for the Ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | exposing the metrics of the GPU on the node it is on |
| ingress.hosts | list | `[{"host":"chart-example.local","paths":[{"path":"/","pathType":"ImplementationSpecific"}]}]` | Ingress hosts configuration |
| ingress.tls | list | `[]` | The TLS configuration for the Ingress |
| log.format | string | `"logfmt"` | Log format to be used by the exporter |
| log.level | string | `"info"` | Log level to be used by the exporter |
| nameOverride | string | `""` | String to partially override fullname template with a string (will prepend the release name) |
| nodeSelector | object | `{}` | The node selector for the deployment |
| nvidiaSmiCommand | string | `"nvidia-smi"` | The command to run to get `nvidia-smi` compatible output. Can be custom path and/or args. |
| podAnnotations | object | `{}` | Annotations for the pods |
| podSecurityContext | object | `{}` | Security context for the pods |
| port | int | `9835` | Port for the exporter to listen to |
| queryFieldNames | list | `["AUTO"]` | `nvidia-smi` fields to be queried by the exporter |
| resources | object | `{}` | The resource requests and limits of the container |
| securityContext | object | `{"privileged":true}` | Security context for the container. Privileged is required for the collector to work properly. |
| service.enabled | bool | `true` | Enables the Service |
| service.nodePort | string | `nil` | The node port to use if service type is NodePort or LoadBalancer. |
| service.port | int | `9835` | Port for the service to use |
| service.type | string | `"ClusterIP"` | Type of the service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| serviceMonitor | object | see [values.yaml](values.yaml) | Prometheus PodMonitor configuration |
| telemetryPath | string | `"/metrics"` | The path to expose the metrics from |
| tolerations | list | `[]` | Tolerations for the pod assignment |
| volumeMounts | list | see [values.yaml](values.yaml) | The container mount configurations for the volumes |
| volumes | list | see [values.yaml](values.yaml) | The volumes to mount from the host |

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Utku Özdemir | <utkuozdemir@gmail.com> | <https://utkuozdemir.org> |

## Source Code

* <https://github.com/utkuozdemir/helm-charts>
