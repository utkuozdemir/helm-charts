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
- Optionally, one of Bitnami's MySQL or PostgreSQL charts as a database dependency (default is MySQL)
  
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
| `otherEnv` | The additional env variable key-value pairs to be passed to the all of the web and worker pods | `{}` |
| `otherSecretEnv` | The additional **sensitive** env variable key-value pairs to be passed to the all of the web and worker pods | `{}` |
| `web.init.enabled` | Use an init container to wait for the db on the web pod | `true` |
| `web.init.image.repository` | Web init container image repository | `busybox` |
| `web.init.image.pullPolicy` | Web init container image pull policy | `IfNotPresent` |
| `web.init.image.tag` | Web init container image tag | `stable` |
| `web.init.resources` | Web init container resource requests and limits | `{}` |
| `web.init.securityContext` | Web initContainer security context | `{}` |
| `web.replicaCount` | Web pod replica count. Investigate the scaling behavior of Huginn before scaling it up and do it at your own risk | `1` |
| `web.updateStrategy` | Update strategy for the web deployment | `Recreate` |
| `web.livenessProbe` | The liveness probe configuration for web pod | `{"initialDelaySeconds":60,"httpGet":{"path":"/","port":"http"}}` |
| `web.readinessProbe` | The readiness probe configuration for web pod | `{"httpGet":{"path":"/","port":"http"}}` |
| `web.port` | The web port number for Huginn inside the container | `3000` |
| `web.resources` | The resource requests and limits of the container | `{}` |
| `web.podAnnotations` | Annotations for the web pod | `{}` |
| `web.podSecurityContext` | Security context for the web pod | `{}` |
| `web.securityContext` | Security context for the web container | `{}` |
| `web.nodeSelector` | The node selector for the web deployment | `{}` |
| `web.tolerations` | Tolerations for the web pod assignment | `[]` |
| `web.affinity` | Affinity for the web pod assignment | `{}` |
| `worker.init.enabled` | Use an init container to wait for the main application on the worker pod | `true` |
| `worker.init.image.repository` | Worker init container image repository | `busybox` |
| `worker.init.image.pullPolicy` | Worker init container image pull policy | `IfNotPresent` |
| `worker.init.image.tag` | Worker init container image tag | `stable` |
| `worker.init.resources` | Worker init container resource requests and limits | `{}` |
| `worker.init.securityContext` | Worker init container security context | `{}` |
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
| `database.type` | The type of the backing database. Valid values are `mysql` and `postgresql`. **Ignored if `mysql.deployChart` or `postgresql.deployChart` is true.** | `""` |
| `database.host` | The host address of the backing database. **Ignored if `mysql.deployChart` or `postgresql.deployChart` is true.** | `nil` |
| `database.name` | The name of the backing database. **Ignored if `mysql.deployChart` or `postgresql.deployChart` is true.** | `nil` |
| `database.username` | The auth username for the backing database. **Ignored if `mysql.deployChart` or `postgresql.deployChart` is true.** | `nil` |
| `database.password` | The auth password of the backing database. **Ignored if `mysql.deployChart` or `postgresql.deployChart` is true.** | `nil` |
| `database.port` | The port number of the backing database. **Ignored if `mysql.deployChart` or `postgresql.deployChart` is true.** | `nil` |
| `mysql.deployChart` | Install a [bitnami/mysql](https://artifacthub.io/packages/helm/bitnami/mysql/8.4.4) instance as a dependency. Mutually exclusive with `postgresql.deployChart` | `true` |
| `mysql` | The configuration for the [bitnami/mysql](https://artifacthub.io/packages/helm/bitnami/mysql/8.4.4) subchart. For additional configuration, see the official chart README | _See below_ |
| `mysql.auth.database` | If `mysql.deployChart` is `true`, the database with this name will be configured in the db and will be used by the application | `huginn` |
| `mysql.auth.username` | If `mysql.deployChart` is `true`, the user with this name will be configured in the db and will be used by the application | `huginn` |
| `mysql.auth.password` | If `mysql.deployChart` is `true`, the user with this password will be configured in the db and will be used by the application. **Make sure you change this to a secure password**  | `ChangeMe!` |
| `mysql.auth.rootPassword` | The MySQL root password. **Used only when `mysql.deployChart` is `true`. Make sure you change this to a secure password**  | `DefinitelyChangeMe!` |
| `postgresql.deployChart` | Install a [bitnami/postgresql](https://artifacthub.io/packages/helm/bitnami/postgresql/10.3.11) instance as a dependency. Mutually exclusive with `mysql.deployChart` | `false` |
| `postgresql` | The configuration for the [bitnami/postgresql](https://artifacthub.io/packages/helm/bitnami/postgresql/10.3.11) subchart. For additional configuration, see the official chart README | _See below_ |
| `postgresql.postgresqlDatabase` | If `postgresql.deployChart` is `true`, the database with this name will be configured in the db and will be used by the application | `huginn` |
| `postgresql.postgresqlUsername` | If `postgresql.deployChart` is `true`, the user with this name will be configured in the db and will be used by the application | `huginn` |
| `postgresql.postgresqlPassword` | If `postgresql.deployChart` is `true`, the user with this name will be configured in the db and will be used by the application. **Make sure you change this to a secure password**  | `ChangeMe!` |
| `postgresql.postgresqlPostgresPassword` | The PostgreSQL admin user password. **Used only when `postgresql.deployChart` is `true`. Make sure you change this to a secure password**  | `DefinitelyChangeMe!` |


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
