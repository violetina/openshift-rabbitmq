FROM rabbitmq:3.7-management-alpine
ENV RABBITMQ_DEFAULT_USER=user 
ENV RABBITMQ_DEFAULT_PASS=password 
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_shovel rabbitmq_shovel_management rabbitmq_tracing

