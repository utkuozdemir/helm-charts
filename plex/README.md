# plex - ⚠️ DEPRECATED

⚠️ **This chart is not maintained anymore. Please switch to using [k8s-at-home/plex](https://github.com/k8s-at-home/charts/tree/master/charts/stable/plex) instead.**

![Version: 2.1.1](https://img.shields.io/badge/Version-2.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.25.2](https://img.shields.io/badge/AppVersion-1.25.2-informational?style=flat-square)

Plex Media Server Helm chart

**Homepage:** <https://www.plex.tv>

## TL;DR

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/plex
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalPorts | list | `[]` | Additional port definitions for the pod |
| additionalServicePorts | list | `[]` | Additional port definitions for the service |
| affinity | object | `{}` | Affinity for the pod assignment |
| dnsConfig | object | `{}` | DNS configuration for the pod |
| dnsPolicy | string | `"ClusterFirst"` | DNS policy for the pod |
| env | object | `{}` | Non-sensitive environment variables to be set in the pods. See the [application docs](https://docs.linuxserver.io/images/docker-plex) |
| extraVolumeMounts | object | `{}` | Arbitrary extra volume mounts for the pod |
| extraVolumes | list | `[]` | Arbitrary extra volume definitions for the pod |
| fullnameOverride | string | `""` | String to fully override fullname template with a string |
| hostNetwork | bool | `false` | Use host network |
| hostPort.enabled | bool | `false` | Use host port for the application |
| hostPort.port | int | `32400` | Host port to bind to |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"docker.io/linuxserver/plex"` | Image repository |
| image.tag | string | `""` | Image tag (if not specified, defaults to the chart's appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.annotations | object | `{}` | Annotations for the ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Expose the app using an ingress |
| ingress.hosts | list | see [values.yaml](values.yaml) | Ingress hosts configuration |
| ingress.tls | list | `[]` | The TLS configuration for the Ingress |
| initContainers | list | `[]` | Init containers |
| livenessProbe | object | `{}` | Pod liveness probe |
| nameOverride | string | `""` | String to partially override fullname template with a string (will prepend the release name) |
| nodeSelector | object | `{}` | The node selector for the deployment |
| persistence.config.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.config.annotations | object | `{}` | Config: Annotations for the claim |
| persistence.config.customVolume | object | `{}` | Config: Alternative data volume definition (e.g. nfs, hostPath). Used when `persistence.config.isPvc` is `false` |
| persistence.config.enabled | bool | `true` | Config: Enable persistence |
| persistence.config.existingClaim | string | `""` | Config: Name of the existing claim to be used for config |
| persistence.config.isPvc | bool | `true` | Config: Persistence type is pvc. When `false`, data volume definition is read from `persistence.config.customVolume` |
| persistence.config.size | string | `"2Gi"` | Config: Size for the claim |
| persistence.config.storageClass | string | `""` | Config: Storage class for the volume |
| persistence.data.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.data.annotations | object | `{}` | Data: Annotations for the claim |
| persistence.data.customVolume | object | `{}` | Data: Alternative data volume definition (e.g. nfs, hostPath). Used when `persistence.data.isPvc` is `false` |
| persistence.data.enabled | bool | `false` | Data: Enable persistence |
| persistence.data.existingClaim | string | `""` | Data: Name of the existing claim to be used |
| persistence.data.isPvc | bool | `true` | Data: Persistence type is pvc. When `false`, data volume definition is read from `persistence.data.customVolume` |
| persistence.data.size | string | `"64Gi"` | Data: Size for the claim |
| persistence.data.storageClass | string | `""` | Data: Storage class for the data volume |
| podAnnotations | object | `{}` | Annotations for the pods |
| podSecurityContext | object | `{}` | Security context for the pods |
| readinessProbe | object | `{"tcpSocket":{"port":"plex"}}` | Pod readiness probe |
| replicaCount | int | `1` | Number of replicas to run. Chart is not designed to scale horizontally, use at your own risk |
| resources | object | `{}` | The resource requests and limits of the container |
| secretEnv | object | `{}` | Sensitive environment variables to be set in the pods. See the [application docs](https://docs.linuxserver.io/images/docker-plex) |
| securityContext | object | `{}` | Security context for the container |
| service.port | int | `32400` | Port for the service to use |
| service.type | string | `"ClusterIP"` | Type of the service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| sidecarContainers | list | `[]` | Sidecar containers |
| strategy | object | `{"type":"Recreate"}` | Deployment strategy |
| tolerations | list | `[]` | Tolerations for the pod assignment |

Alternatively, a YAML file that specifies the values for the parameters
can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml utkuozdemir/plex
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Notes

Note that this is an un-opinionated chart regarding the configuration. What is meant by this is:
The chart passes the set of environment variables as-is into the container, using the `env` and `secretEnv` values.
This way we avoid mapping each and every configuration parameter to an explicitly
named chart parameter and provides a very flexible configuration.

## Upgrading Chart

```console
helm upgrade my-release utkuozdemir/plex
```

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Upgrading an existing Release to a new major version

A major chart version change (like 1.2.0 -> 2.0.0) indicates that
there is an incompatible breaking change needing manual actions.

### From 1.x to 2.x

On version 2.x, the app is backed by a deployment instead of a statefulset.

The values is largely refactored - pay attention to the changes on the `persistence` section.

It is recommended to start from a fresh install.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Utku Özdemir | uoz@protonmail.com | https://utkuozdemir.org |

## Source Code

* <https://github.com/linuxserver/docker-plex>
* <https://github.com/utkuozdemir/helm-charts>
