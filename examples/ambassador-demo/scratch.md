## Add the Repo:
```
helm repo add datawire https://app.getambassador.io
helm repo update
```
 
## Create Namespace and Install:
```
kubectl create namespace ambassador && \
kubectl apply -f https://app.getambassador.io/yaml/edge-stack/3.5.1/aes-crds.yaml
kubectl wait --timeout=90s --for=condition=available deployment emissary-apiext -n emissary-system
helm install edge-stack --namespace ambassador datawire/edge-stack && \
kubectl -n ambassador wait --for condition=available --timeout=90s deploy -lproduct=aes
```

## Configure Ambassador Listeners to route traffic from the edge
```
kubectl apply -f examples/ambassador-demo/ambassador-listeners.yaml
```

## Configure "ConsulResolver" to resolve services registered with Consul
```
kubectl apply -f examples/ambassador-demo/consul-resolver.yaml
```

## Deploy Ambassador Consul Connect
If TLS is enabled in Consul, it requires `connect-ca` certificate to be mounted and set as environment variable. It may not be required if ambassador-consul-connect component is configured to connect to HCP Consul server as the TLS certificate is signed by system trusted CA.

Refer below documents for additional guidance:
- https://docs.google.com/document/d/1XvZD1ImQ4AJCaXQiPXueway0LFxFlFSyesg_ymWw5SQ/edit
- https://hashicorp.atlassian.net/wiki/spaces/CSE/pages/788793859/Consul-Ambassador+Integration

```
kubectl apply -f examples/ambassador-demo/ambassador-consul-connect.yaml
```

## Apply proxy-defaults
```
kubectl apply -f examples/ambassador-demo/proxy-defaults.yml
```

## Apply the YAML for the demo "Quote" service. Update the value for CONSUL_HTTP_TOKEN.
```
kubectl apply -f examples/ambassador-demo/quote-connect.yaml
```
## Generate the YAML for a Mapping to route all traffic inbound to the /quote-connect/ path to the quote Service.
```
kubectl apply -f examples/ambassador-demo/mapping.yaml
```

## Store the Ambassador Edge Stack load balancer IP address to a local environment variable. You will use this variable to test access to your service.
```
export LB_ENDPOINT=$(kubectl -n ambassador get svc  edge-stack \
  -o "go-template={{range .status.loadBalancer.ingress}}{{or .ip .hostname}}{{end}}")
```

## Test the configuration by accessing the service through the Ambassador Edge Stack load balancer:
```
curl -Lki https://$LB_ENDPOINT/backend/
```



