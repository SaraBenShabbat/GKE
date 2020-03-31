provider helm {}

resource "helm_release" "prometheus_grafana" {

  name       = "prometheus-grafana-0"
  repository = "stable"
  chart      = "prometheus-operator"
  timeout    = 1200

  values = [
    "${file("custom.yaml")}"
  ]

  set {
    name  = "prometheusOperator.createCustomResource"
    value = "false"
  }

}

