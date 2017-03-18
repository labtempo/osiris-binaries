# use rabbitmq official
FROM rabbitmq:3-alpine
 
# enable management plugin
RUN rabbitmq-plugins enable --offline rabbitmq_management
 
# enable mqtt plugin
RUN rabbitmq-plugins enable --offline rabbitmq_mqtt
 
# expose management port
EXPOSE 15672
# expose default port
EXPOSE 5672
