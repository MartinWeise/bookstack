# BookStack Helm chart

[BookStack](https://www.bookstackapp.com/) is a simple, self-hosted, easy-to-use platform for organising and storing 
information.

## TL;DR

```bash
helm install my-release "oci://registry-1.docker.io/mweise/bookstack"
```

## Contribute

Before you create a pull-request, make sure you:

- [ ] Update the `values.schema.json` with `helm schema -input ./values.yaml -output ./values.schema.json`
- [ ] Update the `README.md` with `readme-generator --readme ./README.md --values ./values.yaml`

## Parameters