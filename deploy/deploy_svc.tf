provider kubernetes {
  # leave blank to pickup config from kubectl config of local system
}

resource "kubernetes_deployment" "java-app" {
  metadata {
    name = "java-app"
  }

  spec {
    selector {
      match_labels = {
        app = "java-app"

      }
    }

    template {
      metadata {
        labels = {
          app = "java-app"
        }
      }

      spec {
        container {
          image = "gcr.io/solid-justice-272605/java-app:01"
          name  = "java-app"

          resources {
            requests {
              memory = "256Mi"
              cpu    = "100m"
            }

            limits {
              memory = "1Gi"
              cpu    = "500m"
            }
          }

          readiness_probe {
            http_get {
              path = "/"
              port = "8080"
            }

            initial_delay_seconds = 10
            period_seconds        = 10
          }

          liveness_probe {
            http_get {
              path = "/"
              port = "8080"
            }

            initial_delay_seconds = 120
            period_seconds        = 15
          }

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  metadata {
    name = "java-app-svc"
  }

  spec {
    selector = {
      app = "java-app"
    }

    session_affinity = "ClientIP"

    port {
      port = 8080
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = "${kubernetes_service.example.load_balancer_ingress.0.ip}"
}
