# dontstarvetogether

[Don't Starve Together](https://www.klei.com/games/dont-starve-together) is the standalone multiplayer 
expansion of the uncompromising wilderness survival game, Don't Starve.

## TL;DR

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/dontstarvetogether
```

## Introduction

This chart starts a dedicated server of Don't Starve together, running the 
Docker image [Jamesits/docker-dst-server](https://github.com/Jamesits/docker-dst-server)

## Prerequisites

- Kubernetes 1.15+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add utkuozdemir https://utkuozdemir.org/helm-charts
$ helm install my-release utkuozdemir/dontstarvetogether
```

These commands deploy one DST dedicated server in the default configuration. 
The [Parameters](#parameters) section lists the parameters that can be configured during installation.

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
| `persistence.enabled` | Use persistent volume to store data | `true` |
| `persistence.storageClass` | Type of persistent volume claim | `nil` |
| `persistence.accessModes` | Persistence access modes | `["ReadWriteOnce"]` |
| `persistence.size` | Size of persistent volume claim | `"1Gi"` |
| `useHostPorts` | If the server should use hostPort directives for external access | `false` |
| `terminationGracePeriodSeconds` | Duration in seconds the pod needs to terminate gracefully | `120` |
| `podSecurityPolicy.create` | If a PodSecurityPolicy should be created with its required Role and RoleBindings | `false` |
| `image.repository` | Image repository | `"docker.io/jamesits/dst-server"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
| `image.tag` | Image tag (if not speficied, defaults to the chart's appVersion) | `""` |
| `initImage.repository` | Init container image repository | `"docker.io/busybox"` |
| `initImage.pullPolicy` | Init container image pull policy | `"IfNotPresent"` |
| `initImage.tag` | Init container image tag | `"musl"` |
| `imagePullSecrets` | Image pull secrets | `[]` |
| `nameOverride` | String to partially override dontstarvetogether.fullname template with a string (will prepend the release name) | `""` |
| `fullnameOverride` | String to fully override dontstarvetogether.fullname template with a string | `""` |
| `serviceAccount.create` | Create a service account. If `podSecurityPolicy.create` is true, a service account will be created regardless of this flag | `true` |
| `serviceAccount.annotations` | Annotations for the service account | `{}` |
| `serviceAccount.name` | The name of the service account to create | `""` |
| `podAnnotations` | Annotations for the pod | `{}` |
| `podSecurityContext` | Security context for the pod | `{}` |
| `securityContext` | Security context for the container | `{}` |
| `service.type` | Type of the service | `"ClusterIP"` |
| `service.annotations` | Annotations for the service | `{}` |
| `resources` | The resource requests and limits of the container | `{}` |
| `nodeSelector` | The node selector | `{}` |
| `tolerations` | Tolerations for the pod assignment | `[]` |
| `affinity` | Affinity for the pod assignment | `{}` |
| `config.root.clusterToken` | The required cluster token for the DST server | `nil` |
| `config.root.network.cluster_name` | The name of the DST server | `"My Server"` |
| `config.root.network.cluster_description` | The description of the DST server | `"My Server"` |
| `config.root.network.cluster_password` | The password for the DST server | `nil` |
| `config.root.network.offline_cluster` | Whether the DST server should be an offline server | `false` |
| `config.root.network.lan_only_cluster` | Whether the DST server should be LAN only | `false` |
| `config.root.network.cluster_intention` | The intention of the DST server | `"cooperative"` |
| `config.root.network.autosaver_enabled` | Whether the autosaver should be enabled on the DST server | `true` |
| `config.root.network.tick_rate` | The DST server tick rate | `30` |
| `config.root.gameplay.game_mode` | The DST server game mode | `"survival"` |
| `config.root.gameplay.max_players` | Max players for the DST server | `10` |
| `config.root.gameplay.pvp` | Whether the DST server is PVP-enabled or not | `false` |
| `config.root.gameplay.pause_when_empty` | Pause DST server when empty | `true` |
| `config.root.steam.steam_group_only` | Steam group-only DST server | `false` |
| `config.root.steam.steam_group_id` | Steam group id for the group-only DST server | `0` |
| `config.root.steam.steam_group_admins` | Steam group admins for the group-only DST server | `false` |
| `config.root.misc.console_enabled` | Whether the console is enabled on the DST server | `true` |
| `config.root.misc.max_snapshots` | Max snapshots to be stored on the DST server | `6` |
| `config.root.shard.shard_enabled` | Whether the shard should be enabled for DST server or not | `true` |
| `config.root.shard.bind_ip` | DST server bind IP | `"127.0.0.1"` |
| `config.root.shard.master_ip` | DST server master IP | `"127.0.0.1"` |
| `config.root.shard.master_port` | DST server internal communication port | `10998` |
| `config.root.shard.cluster_key` | DST server cluster key | `"MySecretKey"` |
| `config.root.additionalFiles."adminlist.txt"` | The list of admins on the DST server | `""` |
| `config.root.additionalFiles."blocklist.txt"` | The DST server block list | `""` |
| `config.root.additionalFiles."whitelist.txt"` | The DST server white list | `""` |
| `config.master.network.server_port` | The DST server master port | `10999` |
| `config.master.shard.is_master` | Boilerplate | `true` |
| `config.master.account.encode_user_path` | Boilerplate | `true` |
| `config.master.steam.master_server_port` | Steam communication port for master | `12346` |
| `config.master.steam.authentication_port` | Steam authentication port for master | `8766` |
| `config.master.additionalFiles` | Additional files for the master configuration | `{}` |
| `config.caves.network.server_port` | The DST server caves port | `11000` |
| `config.caves.shard.is_master` | Boilerplate | `false` |
| `config.caves.shard.name` | Boilerplate | `"Caves"` |
| `config.caves.account.encode_user_path` | Boilerplate | `true` |
| `config.caves.steam.master_server_port` | Steam communication port for caves | `12347` |
| `config.caves.steam.authentication_port` | Steam authentication port for caves | `8767` |
| `config.caves.additionalFiles` | Additional files for the caves configuration | `{}` |
| `config.mods.additionalFiles."dedicated_server_mods_setup.lua"` | Mod installation configuration (by default, mod installations are commented out) | ```"-- [API] Gem Core (mod dependency) - https://steamcommunity.com/sharedfiles/filedetails/?id=1378549454\n--ServerModSetup(\"1378549454\")\n-- Health Info https://steamcommunity.com/sharedfiles/filedetails/?id=375859599\n--ServerModSetup(\"375859599\")\n-- Global Positions https://steamcommunity.com/sharedfiles/filedetails/?id=378160973\n--ServerModSetup(\"378160973\")\n-- Food Values - Item Tooltips https://steamcommunity.com/sharedfiles/filedetails/?id=458940297\n--ServerModSetup(\"458940297\")\n-- Global Pause https://steamcommunity.com/sharedfiles/filedetails/?id=758532836\n--ServerModSetup(\"758532836\")\n"``` |

The above config parameters map to the various config files and flags of a typical DST dedicated server.

For more information please refer to the 
[Don’t Starve Together Dedicated Server Guide](https://dontstarve.fandom.com/wiki/Guides/Don%E2%80%99t_Starve_Together_Dedicated_Servers)
and to the [Jamesits/docker-dst-server](https://github.com/Jamesits/docker-dst-server) image configuration.

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install my-release \
    --set config.root.network.cluster_name=My Server \
    --set config.root.network.cluster_description=My Description \
    --set config.root.network.cluster_password=MySecretPassword \
    utkuozdemir/dontstarvetogether
```

Alternatively, a YAML file that specifies the values for the above parameters 
can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml utkuozdemir/dontstarvetogether
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration

There are a few configuration parameters that need your attention. Those are:
- `useHostPorts` or `service.type`: **For your server to be accessible, you would either want 
  to set `useHostPorts: true` or `service.type: LoadBalancer`, but not both**.
 
  If you are running a single-node cluster, you can simply use `hostPorts`.
  If your cluster supports external load balancing, 
  you can use `service.type: LoadBalancer` and use the external IP of the service.

- `config.root.clusterToken`: **Every DST server requires a cluster token** - 
  therefore this is a required parameter.
  
  There are different ways to generate a server token. 
  It looks like `pds-g^KU_aiBJDSpM^i7eXaSfdsDdfgvvftDfs42bfZG0TWER0APv3Hjo=`.
  
  See [This page](https://nodecraft.com/support/games/dont-starve-together/how-to-acquire-a-cluster-token) for more information.

- `config.root.network.cluster_name`: Give your server a friendly name - 
  so you can find it easily in the "Browse Server" listings.

- `config.root.network.cluster_description`: Give your server a friendly description.

- `config.root.network.cluster_password`: Protect your server with a strong password.

- The four ports: `config.master.network.server_port`, `config.master.steam.master_server_port`, 
  `config.caves.network.server_port` and `config.master.steam.master_server_port`: 
  If you want to run a single server on a cluster node, you can leave them as-is. However, 
  **if you want to run multiple DST servers on the same node** using `hostPort`s, 
  you will need to use 4 different ports for the second server. 
  See the 2 sample configurations to serve as an example.

- `resources.requests`: I recommend allocating some CPU and memory for your dedicated server
  for a more reliable experience.

- `config` block: The whole config block maps to the typical DST dedicated server configuration.
  So, anything you want to customize - you can do it in this block. 
  As an example, see the "complex" sample values file.

Lastly, see the sample values files for a minimal configuration, 
and for a more complex configuration that enables mods, overrides the ports etc.
