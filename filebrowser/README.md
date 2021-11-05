# filebrowser

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v2.18.0](https://img.shields.io/badge/AppVersion-v2.18.0-informational?style=flat-square)

A Helm chart for the File Browser project

**Homepage:** <https://filebrowser.org>

## TL;DR;

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/filebrowser
```

## Introduction

This chart packages the project **[filebrowser](https://filebrowser.org)** as a Helm chart.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/filebrowser
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

## Upgrade Notes

Please read the upgrade notes before upgrading. There may be breaking changes!

### From 0.1.x to 0.2.x

- The values `persistence.rootDir.*` and `persistence.db.*` are
renamed to `rootDir.pvc.*` and `db.pvc.*`. You should rename your values accordingly.
- A new value `rootDir.type` is introduced. The default value is `pvc`, which is same as the
previous default. You can instead set it to `hostPath` to mount

## Parameters

The following tables lists the configurable parameters of the chart and their default values.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Map of node/pod affinities |
| config | object | see [values.yaml](values.yaml) | File Browser application specific configuration |
| db.pvc.accessModes | list | `["ReadWriteOnce"]` | Access modes for the database PVC |
| db.pvc.enabled | bool | `true` | Enable persistence for database |
| db.pvc.existingClaim | string | `""` | Existing claim for the database |
| db.pvc.size | string | `"256Mi"` | Size for the database PVC |
| db.pvc.storageClassName | string | `""` | Storage class name for the database PVC |
| fullnameOverride | string | `""` | String to fully override the fullname template with a string |
| image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy |
| image.repository | string | `"docker.io/filebrowser/filebrowser"` | Container image name |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Array of imagePullSecrets in the namespace for pulling images |
| ingress.annotations | object | `{}` | Annotations for the Ingress |
| ingress.className | string | `""` | Class name of the Ingress |
| ingress.enabled | bool | `false` | Enable the use of the ingress controller to access the web UI |
| ingress.hosts | list | see [values.yaml](values.yaml) | Hosts for the ingress |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` | Set of initContainers for the deployment |
| livenessProbe | object | `{}` | Liveness probe configuration |
| nameOverride | string | `""` | String to partially override the fullname template with a string (will prepend the release name) |
| nodeSelector | object | `{}` | Node labels for pod assignment |
| podAnnotations | object | `{}` | Annotations of the pods |
| podSecurityContext | object | `{}` | The security context for the pods |
| readinessProbe | object | see [values.yaml](values.yaml) | Readiness probe configuration |
| replicaCount | int | `1` | Number of replicas to run. Chart is not designed to scale horizontally, use at your own risk |
| resources | object | `{}` | The resources to allocate for the container |
| rootDir.hostPath.path | string | `"/path/on/host"` |  |
| rootDir.pvc.accessModes | list | `["ReadWriteOnce"]` | Access modes for the root directory PVC |
| rootDir.pvc.existingClaim | string | `""` | Existing claim for the root directory |
| rootDir.pvc.size | string | `"2Gi"` | Size for the root directory PVC |
| rootDir.pvc.storageClassName | string | `""` | Storage class name for the root directory PVC |
| rootDir.readOnly | bool | `false` | Mount the root directory in read-only mode |
| rootDir.type | string | `"pvc"` | type of rootDir mount. Valid values are [pvc, hostPath, emptyDir] |
| securityContext | object | `{}` | The security context for the application container |
| service.port | int | `80` | Kubernetes Service port |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| strategy | object | `{"type":"Recreate"}` | Deployment strategy to use |
| tolerations | list | `[]` | Tolerations for pod assignment |
