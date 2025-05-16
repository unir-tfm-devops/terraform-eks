resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "8.0.3"
  create_namespace = true

  values = [
    file("helm-values/argocd-values.yaml")
  ]

  depends_on = [module.eks]
}
