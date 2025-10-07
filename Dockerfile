FROM eclipse-temurin:latest
RUN apt-get update && apt-get install -y \
    curl \
    jq

COPY getFolia.sh /setup/getFolia.sh
COPY docker-entrypoint.sh /setup/docker-entrypoint.sh

RUN chmod +x /setup/getFolia.sh
RUN chmod +x /setup/docker-entrypoint.sh

ARG FOLIA_VERSION=latest
RUN echo "$FOLIA_VERSION" > /setup/folia_version

WORKDIR /server

VOLUME /server

ENV MIN_RAM=1G
ENV MAX_RAM=1G
ENV JAVA_FLAGS="--add-modules=jdk.incubator.vector -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20"
ENV FOLIA_FLAGS="--nojline"

ENTRYPOINT ["/setup/docker-entrypoint.sh"]