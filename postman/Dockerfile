FROM postman/newman:5.2.4-alpine

LABEL maintainer="KieniL"
LABEL name="postman"
LABEL version="1.0.0"
LABEL author="KieniL"
LABEL contact="https://github.com/KieniL/FamilyCluster_Config/issues"
LABEL documentation="https://github.com/KieniL/FamilyCluster_Config/tree/master/postman"

ENV ANSPAREN_HOST=http://tmp
ENV API_HOST=http://tmp
ENV AUTH_HOST=http://tmp
ENV CERT_HOST=http://tmp
ENV FOLDERS="--folder \"Login_full\" --folder \"another\""

WORKDIR /etc/newman/
COPY FamilyCluster.postman_collection.json /etc/newman/
RUN chmod -R 700 /etc/newman
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["sh", "./entrypoint.sh"]
