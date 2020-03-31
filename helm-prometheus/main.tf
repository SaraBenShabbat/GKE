provider helm {}

resource "helm_release" "promethues_grafana" {

  name       = "prom-10"
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

