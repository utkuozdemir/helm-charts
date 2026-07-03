# nvidia-gpu-exporter

> [!WARNING]
> This chart is deprecated and receives no further updates.
>
> It moved to [the application repository](https://github.com/utkuozdemir/nvidia_gpu_exporter/tree/main/charts/nvidia-gpu-exporter) and is maintained there as chart 2.x.

Install the new chart:

```console
helm install nvidia-gpu-exporter oci://ghcr.io/utkuozdemir/charts/nvidia-gpu-exporter
```

> [!IMPORTANT]
> The new chart accesses GPUs through the NVIDIA container runtime instead of hand-mounted host paths, so its values are not compatible with this chart. See the "Upgrading from chart 1.x" section of the new chart's README before migrating.
