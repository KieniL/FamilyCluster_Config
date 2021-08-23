package main

import data.kubernetes

name = input.metadata.name
namespace = input.metadata.namespace
spec = input.spec


deny[msg] {
  kubernetes.is_ingress
  not startswith(name, "unittest-")

  msg := sprintf("ingress %v does not start with unittest-. Use: {{ .Release.Name }}- in name", [name])
}

deny[msg] {
  kubernetes.is_ingress
  not spec.tls

  msg := sprintf("ingress %v is not secured by tls", [name])
}

deny[msg] {
  kubernetes.is_ingress
  not spec.rules

  msg := sprintf("ingress %v has not rules section provided", [name])
}