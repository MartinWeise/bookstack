# DBRepo Helm chart

[DBRepo](https://www.ifs.tuwien.ac.at/infrastructures/dbrepo/) is a database repository system that
allows researchers to ingest data into a central, versioned repository through common interfaces.

## TL;DR

Download the
sample [
`values.yaml`](https://gitlab.phaidra.org/fair-data-austria-db-repository/fda-services/-/raw/release-1.6/helm-charts/dbrepo/values.yaml?inline=true)
for your deployment and update the variables, especially `hostname`.

```bash
helm install my-release "oci://registry.datalab.tuwien.ac.at/dbrepo/helm/dbrepo" --values ./values.yaml --version "1.11.1"
```

## Prerequisites

* Kubernetes 1.24+
* Optional PV provisioner support in the underlying infrastructure (for persistence).
* Optional ingress support in the underlying infrastructure:
  e.g. [NGINX](https://docs.nginx.com/nginx-ingress-controller/) (for the UI).
* Optional certificate provisioner support in the underlying infrastructure:
  e.g. [cert-manager](https://cert-manager.io/) (for production use).

## Database Configuration

Note that the default configuration uses a lower memory bound (2GB) than the default MariaDB memory bound (4GB). We
consequently decreased the `innodb_buffer_pool_size` to 1430MB (70% of the available memory). You need to increase this
variable when you increase the available Pod memory for performance.

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release "oci://registry.datalab.tuwien.ac.at/dbrepo/helm" --values ./values.yaml --version "1.11.1"
```

The command deploys DBRepo on the Kubernetes cluster in the default configuration. The Parameters section lists the
parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters