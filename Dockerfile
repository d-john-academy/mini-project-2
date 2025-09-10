FROM tsl0922/ttyd

RUN apt-get update && apt-get install -y jq

COPY scheduler.sh /opt/scheduler.sh

RUN chmod +x /opt/scheduler.sh

EXPOSE 7681

ENTRYPOINT ["ttyd","-W", "bash"]

CMD ["/opt/scheduler.sh"]
