# transmission-openvpn

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 4.0](https://img.shields.io/badge/AppVersion-4.0-informational?style=flat-square)

Transmission + OpenVPN chart based on haugene/transmission-openvpn image

**Homepage:** <https://haugene.github.io/docker-transmission-openvpn>

## TL;DR

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/transmission-openvpn
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for the pod assignment |
| dnsConfig | object | `{}` | DNS configuration for the pod |
| dnsPolicy | string | `"ClusterFirst"` | DNS policy for the pod |
| env | object | `{}` | Non-sensitive environment variables to be set in the pods. See the [application docs](https://haugene.github.io/docker-transmission-openvpn/config-options/) |
| extraVolumeMounts | object | `{}` | Arbitrary extra volume mounts for the pod |
| extraVolumes | list | `[]` | Arbitrary extra volume definitions for the pod |
| fullnameOverride | string | `""` | String to fully override fullname template with a string |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy |
| image.repository | string | `"haugene/transmission-openvpn"` | Image repository |
| image.tag | string | `""` | Image tag (if not specified, defaults to the chart's appVersion) |
| imagePullSecrets | list | `[]` | Image pull secrets |
| ingress.annotations | object | `{}` | Annotations for the ingress |
| ingress.className | string | `""` | Ingress class name |
| ingress.enabled | bool | `false` | Expose the app using an ingress |
| ingress.hosts | list | see [values.yaml](values.yaml) | Ingress hosts configuration |
| ingress.tls | list | `[]` | The TLS configuration for the Ingress |
| livenessProbe | object | `{}` | Pod liveness probe |
| mountTunDevice | bool | `true` | Mount the /dev/net/tun device into the pod. Required by OpenVPN when a `tun` device is used |
| nameOverride | string | `""` | String to partially override fullname template with a string (will prepend the release name) |
| nodeSelector | object | `{}` | The node selector for the deployment |
| persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` | Annotations for the claim |
| persistence.dataVolume | object | `{}` | Alternative data volume definition (e.g. nfs, hostPath). Used when `persistence.isPvc` is `false` |
| persistence.enabled | bool | `false` | Enable persistence |
| persistence.existingClaim | string | `""` | Name of the existing claim to be used |
| persistence.isPvc | bool | `true` | Persistence type is pvc. When `false`, data volume definition is read from `persistence.dataVolume` |
| persistence.size | string | `"64Gi"` | Size for the claim |
| persistence.storageClass | string | `""` | Storage class for the data volume |
| podAnnotations | object | `{}` | Annotations for the pods |
| podSecurityContext | object | `{}` | Security context for the pods |
| readinessProbe | object | `{"tcpSocket":{"port":"http"}}` | Pod readiness probe |
| replicaCount | int | `1` | Number of replicas to run. Chart is not designed to scale horizontally, use at your own risk |
| resources | object | `{}` | The resource requests and limits of the container |
| secretEnv | object | `{}` | Sensitive environment variables to be set in the pods. See the [application docs](https://haugene.github.io/docker-transmission-openvpn/config-options/) |
| securityContext | object | `{"capabilities":{"add":["NET_ADMIN"]}}` | Security context for the container. NET_ADMIN capability is required for the VPN to work properly. |
| service.port | int | `80` | Port for the service to use |
| service.type | string | `"ClusterIP"` | Type of the service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| strategy | object | `{"type":"Recreate"}` | Deployment strategy |
| tolerations | list | `[]` | Tolerations for the pod assignment |

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

Alternatively, if you trust all local networks,
you can specify all [RFC1918 private networks](https://en.wikipedia.org/wiki/Private_network):
```console
helm install ... --set env.LOCAL_NETWORK=10.0.0.0/8,172.16.0.0/12,192.168.0.0/16 ...
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

## Upgrading Chart

```console
helm upgrade my-release utkuozdemir/transmission-openvpn
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

* <https://github.com/haugene/docker-transmission-openvpn>
* <https://github.com/utkuozdemir/helm-charts>
