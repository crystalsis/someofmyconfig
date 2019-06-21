$KUBE_VERSION=v1.11.0
$KUBE_PAUSE_VERSION=3.1
$ETCD_VERSION=3.2.18
$CORE_DNS_VERSION=1.1.3

$K8S_GCR_URL=k8s.gcr.io
$K8S_MIRROR_URL=gcr.azk8s.cn/google_containers

foreach($line in Get-Content .\images.properties) {
    $key = $K8S_GCR_URL;
    $value = $K8S_MIRROR_URL;
    Write-Output "$key=$value"
    docker pull ${value}
    docker tag ${value} ${key}
    docker rmi ${value}
}