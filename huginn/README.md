# huginn

[Huginn](https://github.com/huginn/huginn) Huginn is a system for 
building agents that perform automated tasks for you online.

## TL;DR

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/huginn
```

## Introduction

This chart installs and starts 3 applications:

- The Huginn main instance that also function as the web interface 
- A Huginn worker instance
- Bitnami's MySQL chart as a dependency as the database
  
It is based on the [single-process docker image of Huginn](https://hub.docker.com/r/huginn/huginn-single-process).

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/huginn
```

These commands deploy Huginn in the default configuration. 
The [Parameters](#parameters) section lists the parameters 
that can be configured during installation.

**!!! Make sure you replace the default passwords with secure ones !!!**

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
| `image.repository` | Image repository | `"huginn/huginn-single-process"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
| `image.tag` | Image tag (if not specified, defaults to the chart's appVersion) | `""` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `nameOverride` | String to partially override huginn.fullname template with a string (will prepend the release name) | `""` |
| `fullnameOverride` | String to fully override huginn.fullname template with a string | `""` |
| `serviceAccount.create` | Create a service account | `true` |
| `serviceAccount.annotations` | Annotations for the service account | `{}` |
| `serviceAccount.name` | The name of the service account to create | `""` |
| `service.type` | Type of the service | `"ClusterIP"` |
| `service.annotations` | Annotations for the service | `{}` |
| `ingress.enabled` | Enable the use of the ingress controller to access the web UI | `false` |
| `ingress.annotations` | Annotations for the Ingress | `{}` |
| `ingress.hosts[0].host` | Hostname to your installation | `chart-example.local` |
| `ingress.hosts[0].paths` | Path within the url structure | `[]` |
| `ingress.tls` | The TLS configuration for the ingress | `[]` |
| `web.replicaCount` | Web pod replica count. Investigate the scaling behavior of Huginn before scaling it up and do it at your own risk | `1` |
| `web.updateStrategy` | Update strategy for the web deployment | `Recreate` |
| `web.port` | TODO | `3000` |
| `web.resources` | The resource requests and limits of the container | `{}` |
| `web.podAnnotations` | Annotations for the web pod | `{}` |
| `web.podSecurityContext` | Security context for the web pod | `{}` |
| `web.securityContext` | Security context for the web container | `{}` |
| `web.nodeSelector` | The node selector for the web deployment | `{}` |
| `web.tolerations` | Tolerations for the web pod assignment | `[]` |
| `web.affinity` | Affinity for the web pod assignment | `{}` |
| `worker.replicaCount` | Worker pod replica count. Investigate the scaling behavior of Huginn before scaling it up and do it at your own risk | `1` |
| `worker.updateStrategy` | Update strategy for the web deployment | `Recreate` |
| `worker.podAnnotations` | Annotations for the worker pod | `{}` |
| `worker.podSecurityContext` | Security context for the worker pod | `{}` |
| `worker.securityContext` | Security context for the worker container | `{}` |
| `worker.resources` | The resource requests and limits of the worker container | `{}` |
| `worker.nodeSelector` | The node selector for the worker deployment | `{}` |
| `worker.tolerations` | Tolerations for the worker pod assignment | `[]` |
| `worker.affinity` | Affinity for the worker pod assignment | `{}` |
| `seed.enabled` | Seed the database with an initial admin user | `true` |
| `seed.username` | If `seed.enabled` is `true`, the username for the initial user | `admin` |
| `seed.password` | If `seed.enabled` is `true`, the password for the initial user. **Make sure you change this to a secure password** | `ChangeMe!` |
| `mysql.install` | Install a [bitnami/mysql](https://artifacthub.io/packages/helm/bitnami/mysql/8.4.4) instance as a dependency | `true` |
| `mysql` | The configuration for the [bitnami/mysql](https://artifacthub.io/packages/helm/bitnami/mysql/8.4.4) subchart. For additional configuration, see the official chart README | _See below_ |
| `mysql.auth.database` | The database name for Huginn to connect to. If `mysql.install` is `true`, the database with this name will be created as well | `huginn` |
| `mysql.auth.username` | The MySQL DB username for Huginn to use. If `mysql.install` is `true`, the user with this name will be configured as well  | `huginn` |
| `mysql.auth.password` | The MySQL DB password for Huginn to use. If `mysql.install` is `true`, the user with this password will be configured as well. **Make sure you change this to a secure password**  | `ChangeMe!` |
| `mysql.auth.rootPassword` | The MySQL root password. **Used only when `mysql.install` is `true`. Make sure you change this to a secure password**  | `DefinitelyChangeMe!` |


The above config parameters map to the various configuration env variables of a typical Huginn server.

For more information please refer to the 
[Huginn Installation Guide](https://github.com/huginn/huginn/blob/master/doc/manual/installation.md)
and to the [Docker examples for Huginn](https://github.com/huginn/huginn/tree/master/docker/single-process).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install my-release \
    --set seed.username=utku \
    --set seed.password=MyReallyStrongPassword111 \
    --set mysql.auth.password=MyStrongDbPassword111 \
    --set mysql.auth.rootPassword=MyEvenStrongerDbRootPassword111 \
    utkuozdemir/huginn
```

Alternatively, a YAML file that specifies the values for the above parameters 
can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml utkuozdemir/huginn
```

> **Tip**: You can use the default [values.yaml](values.yaml) (but set strong passwords)
