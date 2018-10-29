FROM rabbitmq:3.7-management-alpine
#ENV RABBITMQ_DEFAULT_USER=admin 
#ENV RABBITMQ_DEFAULT_PASS=password 
#ENV RABBITMQ_ERLANG_COOKIE=NomNomAc00cKie
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_shovel rabbitmq_shovel_management rabbitmq_tracing rabbitmq_peer_discovery_k8s rabbitmq_peer_discovery_etcd

