# transmission-openvpn

This is a helm chart for the 
[haugene/docker-transmission-openvpn](https://github.com/haugene/docker-transmission-openvpn) image.

## TL;DR;

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/transmission-openvpn
```

## Introduction

This chart simply maps the features of the docker-transmission-openvpn project to the Kubernetes concepts.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/transmission-openvpn
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
| `image.repository` | container image name | `haugene/transmission-openvpn` |
| `image.tag` | container image tag | `{TAG_NAME}` (taken from the chart appVersion) |
| `image.pullPolicy` | container image pull policy | `IfNotPresent` |
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
| `affinity` | Map of node/pod affinities | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Tolerations for pod assignment | `[]` |
| `persistence.data.enabled` | Enable persistence | `false` |
| `persistence.data.existingClaim` | Use a existing PVC which must be created manually before bound | `nil` |
| `persistence.data.storageClass` | Specify the `storageClass` used to provision the volume | `nil` |
| `storegateway.persistence.accessModes` | Access modes of data volume  | `["ReadWriteOnce"]` |
| `persistence.data.size` | Size for the PV | `64Gi` |
| `env` | The **non-sensitive** environment variables to configure the application. See the possible configuration here: https://haugene.github.io/docker-transmission-openvpn/arguments/ | `{}` |
| `secretEnv` | The **sensitive** environment variables to configure the application. See the possible configuration here: https://haugene.github.io/docker-transmission-openvpn/arguments/ | `{}` |
| `customProvider.enabled` | Use a custom OpenVPN provider service. More info: https://haugene.github.io/docker-transmission-openvpn/supported-providers/#using_a_custom_provider | `false` |
| `customProvider.secretName` | If a custom provider is used, the name of the secret that contains the OpenVPN client configuration files. | `openvpn-custom` |
| `tunDeviceMountFromHost.enabled` | Mount the `tun` device from the host to the container, in case `tun` is used as the OpenVPN connection type | `true` |
| `timezoneMountFromHost.enabled` | Mount the timezone file from the host | `true` |
| `timezoneMountFromHost.name` | The name of the tz database file to mount. More info: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones | `localtime` |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set env.LOCAL_NETWORK=10.217.0.0/16 \
  --set env.OPENVPN_PROVIDER=PIA \
  --set env.OPENVPN_USERNAME=myuser \
  --set env.TRANSMISSION_SPEED_LIMIT_UP_ENABLED=true \
  --set env.TRANSMISSION_SPEED_LIMIT_UP=2048 \
  --set secretEnv.OPENVPN_PASSWORD=mysecretpassword \
  utkuozdemir/transmission-openvpn
```

The above command uses *PIA* as the OpenVPN provider, uses the VPN username `myuser` 
and password `mysecretpassword` to connect to the provider.
It also enables the transmission upload speed limit and sets it to 2048 KB/s.

Alternatively, a YAML file that specifies the values for the parameters 
can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml utkuozdemir/transmission-openvpn
```

> **Tip**: You can use the default [values.yaml](values.yaml)


## Notes

**Important Note:** By default, the `docker-transmission-openvpn` image **blocks all the incoming traffic** other than 
the traffic coming from the VPN tunnel.

A set of IP ranges can be speficied as the "local network" to be excluded from this block.  
For the service/ingress to work, **you need to specify your Kubernetes cluster pod range as the local network**.  
In the example above, `10.217.0.0/16` is specified as the pod range.

You can find out your cluster's pod range via the following command:
```console
kubectl -n kube-system get pod -o yaml -l component=kube-controller-manager | grep cluster-cidr
```

Note that this is an un-opinionated chart regarding the configuration. What is meant by this is:  
The chart passes the set of environment variables as-is into the container, using the `env` and `secretEnv` values.  
This way we avoid mapping each and every configuration parameter to an explicitly 
named chart parameter and provides a very flexible configuration.

See all the possible environment variables 
[on this page](https://haugene.github.io/docker-transmission-openvpn/arguments/).

Note that the transmission application can be fully configured via the environment variables. 
[See this section](https://haugene.github.io/docker-transmission-openvpn/arguments/#transmission_configuration_options) 
for the transmission configuration mapping to the environment.
